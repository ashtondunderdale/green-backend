using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;

namespace green_backend.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class GreenController : ControllerBase
    {
        private readonly ILogger<GreenController> _logger;

        public GreenController(ILogger<GreenController> logger)
        {
            _logger = logger;
        }
    }
}
