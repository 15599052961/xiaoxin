#pragma once


namespace mc_system
{
	/// <summary>
	/// Enum err
	/// </summary>
	enum err{
		SUCCESS = 0,

		FAILED = -1,

		/// <summary>
		/// function invoke repeating
		/// </summary>
		FUNCTION_INVOKE_REPEATING = -100,

		/// <summary>
		/// it occurs the error that maybe not call initialize function
		/// </summary>
		DO_NOT_INITIALIZE = -101,

		/// <summary>
		/// the part maybe not work
		/// </summary>
		NOT_WORK_PARTIAL = -102,

		/// <summary>
		/// allocate memory failed
		/// </summary>
		ALLOCATE_MEMORY_FAILED = -103,

		/// <summary>
		/// not enough memory
		/// </summary>
		NOT_ENOUGH_MEMORY = -104,

		/// <summary>
		/// don't get anything or do nothing etc.
		/// </summary>
		NOTHING = -105,
	};
};

