
async function test() {
  try {
    const loginRes = await fetch('http://localhost:5000/api/auth/login', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ email: 'test@fintask.com', password: 'password123' })
    });
    const loginData = await loginRes.json();
    if (!loginData.success) {
      console.error('Login Failed:', loginData.message);
      return;
    }
    const token = loginData.data.token;
    console.log('✅ Login Successful. Token obtained.');

    const taskRes = await fetch('http://localhost:5000/api/tasks?status=all&priority=all&search=&page=1&limit=10', {
      headers: { 'Authorization': `Bearer ${token}` }
    });
    const taskData = await taskRes.json();
    
    console.log('📊 Tasks API Status:', taskRes.status);
    if (taskRes.status === 200) {
      console.log('🎉 SUCCESS! Tasks retrieved:', taskData.data?.tasks?.length);
      console.log('📦 Data Structure Check (tasks exists?):', !!taskData.data?.tasks);
    } else {
      console.log('❌ FAILED! Error:', JSON.stringify(taskData, null, 2));
    }
  } catch (err) {
    console.error('💥 Script Error:', err.message);
  }
}

test();
