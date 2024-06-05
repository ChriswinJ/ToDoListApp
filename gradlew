package com.example.todolistapp

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.todolistapp.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMainBinding
    private val tasks = mutableListOf<String>()
    private lateinit var taskAdapter: TaskAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        taskAdapter = TaskAdapter(tasks) { position -> removeTask(position) }
        binding.recyclerView.apply {
            layoutManager = LinearLayoutManager(this@MainActivity)
            adapter = taskAdapter
        }

        binding.buttonAdd.setOnClickListener {
            val task = binding.editTextTask.text.toString()
            if (task.isNotEmpty()) {
                addTask(task)
                binding.editTextTask.text.clear()
            }
        }
    }

    private fun addTask(task: String) {
        tasks.add(task)
        taskAdapter.notifyItemInserted(tasks.size - 1)
    }

    private fun removeTask(position: Int) {
        tasks.removeAt(position)
        taskAdapter.notifyItemRemoved(position)
    }
}
