Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215A5C43613
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 23:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB88320851
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 23:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbfFSXwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 19:52:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:53325 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfFSXwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 19:52:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 16:51:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,394,1557212400"; 
   d="gz'50?scan'50,208,50";a="358352575"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 19 Jun 2019 16:51:57 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hdkMu-0003Yh-8M; Thu, 20 Jun 2019 07:51:56 +0800
Date:   Thu, 20 Jun 2019 07:51:20 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Kan Liang <kan.liang@linux.intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tipbuild@zytor.com, Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [tip:perf/core 24/33] arch/x86//events/intel/core.c:4990:7: error:
 'INTEL_FAM6_ICELAKE_XEON_D' undeclared; did you mean 'INTEL_FAM6_ICELAKE_X'?
Message-ID: <201906200716.1RRyilXG%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
head:   3ce5aceb5dee298b082adfa2baa0df5a447c1b0b
commit: faaeff98666c24376cebd0b106504d05a36881d1 [24/33] perf/x86/intel: Add more Icelake CPUIDs
config: x86_64-rhel-7.6 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout faaeff98666c24376cebd0b106504d05a36881d1
        # save the attached .config to linux build tree
        make ARCH=x86_64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86//events/intel/core.c: In function 'intel_pmu_init':
   arch/x86//events/intel/core.c:4989:7: error: 'INTEL_FAM6_ICELAKE_X' undeclared (first use in this function); did you mean 'INTEL_FAM6_SKYLAKE_X'?
     case INTEL_FAM6_ICELAKE_X:
          ^~~~~~~~~~~~~~~~~~~~
          INTEL_FAM6_SKYLAKE_X
   arch/x86//events/intel/core.c:4989:7: note: each undeclared identifier is reported only once for each function it appears in
>> arch/x86//events/intel/core.c:4990:7: error: 'INTEL_FAM6_ICELAKE_XEON_D' undeclared (first use in this function); did you mean 'INTEL_FAM6_ICELAKE_X'?
     case INTEL_FAM6_ICELAKE_XEON_D:
          ^~~~~~~~~~~~~~~~~~~~~~~~~
          INTEL_FAM6_ICELAKE_X
   arch/x86//events/intel/core.c:4993:7: error: 'INTEL_FAM6_ICELAKE_DESKTOP' undeclared (first use in this function); did you mean 'INTEL_FAM6_SKYLAKE_DESKTOP'?
     case INTEL_FAM6_ICELAKE_DESKTOP:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~
          INTEL_FAM6_SKYLAKE_DESKTOP

vim +4990 arch/x86//events/intel/core.c

  4474	
  4475	__init int intel_pmu_init(void)
  4476	{
  4477		struct attribute **extra_skl_attr = &empty_attrs;
  4478		struct attribute **extra_attr = &empty_attrs;
  4479		struct attribute **td_attr    = &empty_attrs;
  4480		struct attribute **mem_attr   = &empty_attrs;
  4481		struct attribute **tsx_attr   = &empty_attrs;
  4482		union cpuid10_edx edx;
  4483		union cpuid10_eax eax;
  4484		union cpuid10_ebx ebx;
  4485		struct event_constraint *c;
  4486		unsigned int unused;
  4487		struct extra_reg *er;
  4488		bool pmem = false;
  4489		int version, i;
  4490		char *name;
  4491	
  4492		if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
  4493			switch (boot_cpu_data.x86) {
  4494			case 0x6:
  4495				return p6_pmu_init();
  4496			case 0xb:
  4497				return knc_pmu_init();
  4498			case 0xf:
  4499				return p4_pmu_init();
  4500			}
  4501			return -ENODEV;
  4502		}
  4503	
  4504		/*
  4505		 * Check whether the Architectural PerfMon supports
  4506		 * Branch Misses Retired hw_event or not.
  4507		 */
  4508		cpuid(10, &eax.full, &ebx.full, &unused, &edx.full);
  4509		if (eax.split.mask_length < ARCH_PERFMON_EVENTS_COUNT)
  4510			return -ENODEV;
  4511	
  4512		version = eax.split.version_id;
  4513		if (version < 2)
  4514			x86_pmu = core_pmu;
  4515		else
  4516			x86_pmu = intel_pmu;
  4517	
  4518		x86_pmu.version			= version;
  4519		x86_pmu.num_counters		= eax.split.num_counters;
  4520		x86_pmu.cntval_bits		= eax.split.bit_width;
  4521		x86_pmu.cntval_mask		= (1ULL << eax.split.bit_width) - 1;
  4522	
  4523		x86_pmu.events_maskl		= ebx.full;
  4524		x86_pmu.events_mask_len		= eax.split.mask_length;
  4525	
  4526		x86_pmu.max_pebs_events		= min_t(unsigned, MAX_PEBS_EVENTS, x86_pmu.num_counters);
  4527	
  4528		/*
  4529		 * Quirk: v2 perfmon does not report fixed-purpose events, so
  4530		 * assume at least 3 events, when not running in a hypervisor:
  4531		 */
  4532		if (version > 1) {
  4533			int assume = 3 * !boot_cpu_has(X86_FEATURE_HYPERVISOR);
  4534	
  4535			x86_pmu.num_counters_fixed =
  4536				max((int)edx.split.num_counters_fixed, assume);
  4537		}
  4538	
  4539		if (version >= 4)
  4540			x86_pmu.counter_freezing = !disable_counter_freezing;
  4541	
  4542		if (boot_cpu_has(X86_FEATURE_PDCM)) {
  4543			u64 capabilities;
  4544	
  4545			rdmsrl(MSR_IA32_PERF_CAPABILITIES, capabilities);
  4546			x86_pmu.intel_cap.capabilities = capabilities;
  4547		}
  4548	
  4549		intel_ds_init();
  4550	
  4551		x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
  4552	
  4553		/*
  4554		 * Install the hw-cache-events table:
  4555		 */
  4556		switch (boot_cpu_data.x86_model) {
  4557		case INTEL_FAM6_CORE_YONAH:
  4558			pr_cont("Core events, ");
  4559			name = "core";
  4560			break;
  4561	
  4562		case INTEL_FAM6_CORE2_MEROM:
  4563			x86_add_quirk(intel_clovertown_quirk);
  4564			/* fall through */
  4565	
  4566		case INTEL_FAM6_CORE2_MEROM_L:
  4567		case INTEL_FAM6_CORE2_PENRYN:
  4568		case INTEL_FAM6_CORE2_DUNNINGTON:
  4569			memcpy(hw_cache_event_ids, core2_hw_cache_event_ids,
  4570			       sizeof(hw_cache_event_ids));
  4571	
  4572			intel_pmu_lbr_init_core();
  4573	
  4574			x86_pmu.event_constraints = intel_core2_event_constraints;
  4575			x86_pmu.pebs_constraints = intel_core2_pebs_event_constraints;
  4576			pr_cont("Core2 events, ");
  4577			name = "core2";
  4578			break;
  4579	
  4580		case INTEL_FAM6_NEHALEM:
  4581		case INTEL_FAM6_NEHALEM_EP:
  4582		case INTEL_FAM6_NEHALEM_EX:
  4583			memcpy(hw_cache_event_ids, nehalem_hw_cache_event_ids,
  4584			       sizeof(hw_cache_event_ids));
  4585			memcpy(hw_cache_extra_regs, nehalem_hw_cache_extra_regs,
  4586			       sizeof(hw_cache_extra_regs));
  4587	
  4588			intel_pmu_lbr_init_nhm();
  4589	
  4590			x86_pmu.event_constraints = intel_nehalem_event_constraints;
  4591			x86_pmu.pebs_constraints = intel_nehalem_pebs_event_constraints;
  4592			x86_pmu.enable_all = intel_pmu_nhm_enable_all;
  4593			x86_pmu.extra_regs = intel_nehalem_extra_regs;
  4594	
  4595			mem_attr = nhm_mem_events_attrs;
  4596	
  4597			/* UOPS_ISSUED.STALLED_CYCLES */
  4598			intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
  4599				X86_CONFIG(.event=0x0e, .umask=0x01, .inv=1, .cmask=1);
  4600			/* UOPS_EXECUTED.CORE_ACTIVE_CYCLES,c=1,i=1 */
  4601			intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] =
  4602				X86_CONFIG(.event=0xb1, .umask=0x3f, .inv=1, .cmask=1);
  4603	
  4604			intel_pmu_pebs_data_source_nhm();
  4605			x86_add_quirk(intel_nehalem_quirk);
  4606			x86_pmu.pebs_no_tlb = 1;
  4607			extra_attr = nhm_format_attr;
  4608	
  4609			pr_cont("Nehalem events, ");
  4610			name = "nehalem";
  4611			break;
  4612	
  4613		case INTEL_FAM6_ATOM_BONNELL:
  4614		case INTEL_FAM6_ATOM_BONNELL_MID:
  4615		case INTEL_FAM6_ATOM_SALTWELL:
  4616		case INTEL_FAM6_ATOM_SALTWELL_MID:
  4617		case INTEL_FAM6_ATOM_SALTWELL_TABLET:
  4618			memcpy(hw_cache_event_ids, atom_hw_cache_event_ids,
  4619			       sizeof(hw_cache_event_ids));
  4620	
  4621			intel_pmu_lbr_init_atom();
  4622	
  4623			x86_pmu.event_constraints = intel_gen_event_constraints;
  4624			x86_pmu.pebs_constraints = intel_atom_pebs_event_constraints;
  4625			x86_pmu.pebs_aliases = intel_pebs_aliases_core2;
  4626			pr_cont("Atom events, ");
  4627			name = "bonnell";
  4628			break;
  4629	
  4630		case INTEL_FAM6_ATOM_SILVERMONT:
  4631		case INTEL_FAM6_ATOM_SILVERMONT_X:
  4632		case INTEL_FAM6_ATOM_SILVERMONT_MID:
  4633		case INTEL_FAM6_ATOM_AIRMONT:
  4634		case INTEL_FAM6_ATOM_AIRMONT_MID:
  4635			memcpy(hw_cache_event_ids, slm_hw_cache_event_ids,
  4636				sizeof(hw_cache_event_ids));
  4637			memcpy(hw_cache_extra_regs, slm_hw_cache_extra_regs,
  4638			       sizeof(hw_cache_extra_regs));
  4639	
  4640			intel_pmu_lbr_init_slm();
  4641	
  4642			x86_pmu.event_constraints = intel_slm_event_constraints;
  4643			x86_pmu.pebs_constraints = intel_slm_pebs_event_constraints;
  4644			x86_pmu.extra_regs = intel_slm_extra_regs;
  4645			x86_pmu.flags |= PMU_FL_HAS_RSP_1;
  4646			td_attr = slm_events_attrs;
  4647			extra_attr = slm_format_attr;
  4648			pr_cont("Silvermont events, ");
  4649			name = "silvermont";
  4650			break;
  4651	
  4652		case INTEL_FAM6_ATOM_GOLDMONT:
  4653		case INTEL_FAM6_ATOM_GOLDMONT_X:
  4654			x86_add_quirk(intel_counter_freezing_quirk);
  4655			memcpy(hw_cache_event_ids, glm_hw_cache_event_ids,
  4656			       sizeof(hw_cache_event_ids));
  4657			memcpy(hw_cache_extra_regs, glm_hw_cache_extra_regs,
  4658			       sizeof(hw_cache_extra_regs));
  4659	
  4660			intel_pmu_lbr_init_skl();
  4661	
  4662			x86_pmu.event_constraints = intel_slm_event_constraints;
  4663			x86_pmu.pebs_constraints = intel_glm_pebs_event_constraints;
  4664			x86_pmu.extra_regs = intel_glm_extra_regs;
  4665			/*
  4666			 * It's recommended to use CPU_CLK_UNHALTED.CORE_P + NPEBS
  4667			 * for precise cycles.
  4668			 * :pp is identical to :ppp
  4669			 */
  4670			x86_pmu.pebs_aliases = NULL;
  4671			x86_pmu.pebs_prec_dist = true;
  4672			x86_pmu.lbr_pt_coexist = true;
  4673			x86_pmu.flags |= PMU_FL_HAS_RSP_1;
  4674			td_attr = glm_events_attrs;
  4675			extra_attr = slm_format_attr;
  4676			pr_cont("Goldmont events, ");
  4677			name = "goldmont";
  4678			break;
  4679	
  4680		case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
  4681			x86_add_quirk(intel_counter_freezing_quirk);
  4682			memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
  4683			       sizeof(hw_cache_event_ids));
  4684			memcpy(hw_cache_extra_regs, glp_hw_cache_extra_regs,
  4685			       sizeof(hw_cache_extra_regs));
  4686	
  4687			intel_pmu_lbr_init_skl();
  4688	
  4689			x86_pmu.event_constraints = intel_slm_event_constraints;
  4690			x86_pmu.extra_regs = intel_glm_extra_regs;
  4691			/*
  4692			 * It's recommended to use CPU_CLK_UNHALTED.CORE_P + NPEBS
  4693			 * for precise cycles.
  4694			 */
  4695			x86_pmu.pebs_aliases = NULL;
  4696			x86_pmu.pebs_prec_dist = true;
  4697			x86_pmu.lbr_pt_coexist = true;
  4698			x86_pmu.flags |= PMU_FL_HAS_RSP_1;
  4699			x86_pmu.flags |= PMU_FL_PEBS_ALL;
  4700			x86_pmu.get_event_constraints = glp_get_event_constraints;
  4701			td_attr = glm_events_attrs;
  4702			/* Goldmont Plus has 4-wide pipeline */
  4703			event_attr_td_total_slots_scale_glm.event_str = "4";
  4704			extra_attr = slm_format_attr;
  4705			pr_cont("Goldmont plus events, ");
  4706			name = "goldmont_plus";
  4707			break;
  4708	
  4709		case INTEL_FAM6_ATOM_TREMONT_X:
  4710			x86_pmu.late_ack = true;
  4711			memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
  4712			       sizeof(hw_cache_event_ids));
  4713			memcpy(hw_cache_extra_regs, tnt_hw_cache_extra_regs,
  4714			       sizeof(hw_cache_extra_regs));
  4715			hw_cache_event_ids[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)] = -1;
  4716	
  4717			intel_pmu_lbr_init_skl();
  4718	
  4719			x86_pmu.event_constraints = intel_slm_event_constraints;
  4720			x86_pmu.extra_regs = intel_tnt_extra_regs;
  4721			/*
  4722			 * It's recommended to use CPU_CLK_UNHALTED.CORE_P + NPEBS
  4723			 * for precise cycles.
  4724			 */
  4725			x86_pmu.pebs_aliases = NULL;
  4726			x86_pmu.pebs_prec_dist = true;
  4727			x86_pmu.lbr_pt_coexist = true;
  4728			x86_pmu.flags |= PMU_FL_HAS_RSP_1;
  4729			x86_pmu.get_event_constraints = tnt_get_event_constraints;
  4730			extra_attr = slm_format_attr;
  4731			pr_cont("Tremont events, ");
  4732			name = "Tremont";
  4733			break;
  4734	
  4735		case INTEL_FAM6_WESTMERE:
  4736		case INTEL_FAM6_WESTMERE_EP:
  4737		case INTEL_FAM6_WESTMERE_EX:
  4738			memcpy(hw_cache_event_ids, westmere_hw_cache_event_ids,
  4739			       sizeof(hw_cache_event_ids));
  4740			memcpy(hw_cache_extra_regs, nehalem_hw_cache_extra_regs,
  4741			       sizeof(hw_cache_extra_regs));
  4742	
  4743			intel_pmu_lbr_init_nhm();
  4744	
  4745			x86_pmu.event_constraints = intel_westmere_event_constraints;
  4746			x86_pmu.enable_all = intel_pmu_nhm_enable_all;
  4747			x86_pmu.pebs_constraints = intel_westmere_pebs_event_constraints;
  4748			x86_pmu.extra_regs = intel_westmere_extra_regs;
  4749			x86_pmu.flags |= PMU_FL_HAS_RSP_1;
  4750	
  4751			mem_attr = nhm_mem_events_attrs;
  4752	
  4753			/* UOPS_ISSUED.STALLED_CYCLES */
  4754			intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
  4755				X86_CONFIG(.event=0x0e, .umask=0x01, .inv=1, .cmask=1);
  4756			/* UOPS_EXECUTED.CORE_ACTIVE_CYCLES,c=1,i=1 */
  4757			intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] =
  4758				X86_CONFIG(.event=0xb1, .umask=0x3f, .inv=1, .cmask=1);
  4759	
  4760			intel_pmu_pebs_data_source_nhm();
  4761			extra_attr = nhm_format_attr;
  4762			pr_cont("Westmere events, ");
  4763			name = "westmere";
  4764			break;
  4765	
  4766		case INTEL_FAM6_SANDYBRIDGE:
  4767		case INTEL_FAM6_SANDYBRIDGE_X:
  4768			x86_add_quirk(intel_sandybridge_quirk);
  4769			x86_add_quirk(intel_ht_bug);
  4770			memcpy(hw_cache_event_ids, snb_hw_cache_event_ids,
  4771			       sizeof(hw_cache_event_ids));
  4772			memcpy(hw_cache_extra_regs, snb_hw_cache_extra_regs,
  4773			       sizeof(hw_cache_extra_regs));
  4774	
  4775			intel_pmu_lbr_init_snb();
  4776	
  4777			x86_pmu.event_constraints = intel_snb_event_constraints;
  4778			x86_pmu.pebs_constraints = intel_snb_pebs_event_constraints;
  4779			x86_pmu.pebs_aliases = intel_pebs_aliases_snb;
  4780			if (boot_cpu_data.x86_model == INTEL_FAM6_SANDYBRIDGE_X)
  4781				x86_pmu.extra_regs = intel_snbep_extra_regs;
  4782			else
  4783				x86_pmu.extra_regs = intel_snb_extra_regs;
  4784	
  4785	
  4786			/* all extra regs are per-cpu when HT is on */
  4787			x86_pmu.flags |= PMU_FL_HAS_RSP_1;
  4788			x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
  4789	
  4790			td_attr  = snb_events_attrs;
  4791			mem_attr = snb_mem_events_attrs;
  4792	
  4793			/* UOPS_ISSUED.ANY,c=1,i=1 to count stall cycles */
  4794			intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
  4795				X86_CONFIG(.event=0x0e, .umask=0x01, .inv=1, .cmask=1);
  4796			/* UOPS_DISPATCHED.THREAD,c=1,i=1 to count stall cycles*/
  4797			intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] =
  4798				X86_CONFIG(.event=0xb1, .umask=0x01, .inv=1, .cmask=1);
  4799	
  4800			extra_attr = nhm_format_attr;
  4801	
  4802			pr_cont("SandyBridge events, ");
  4803			name = "sandybridge";
  4804			break;
  4805	
  4806		case INTEL_FAM6_IVYBRIDGE:
  4807		case INTEL_FAM6_IVYBRIDGE_X:
  4808			x86_add_quirk(intel_ht_bug);
  4809			memcpy(hw_cache_event_ids, snb_hw_cache_event_ids,
  4810			       sizeof(hw_cache_event_ids));
  4811			/* dTLB-load-misses on IVB is different than SNB */
  4812			hw_cache_event_ids[C(DTLB)][C(OP_READ)][C(RESULT_MISS)] = 0x8108; /* DTLB_LOAD_MISSES.DEMAND_LD_MISS_CAUSES_A_WALK */
  4813	
  4814			memcpy(hw_cache_extra_regs, snb_hw_cache_extra_regs,
  4815			       sizeof(hw_cache_extra_regs));
  4816	
  4817			intel_pmu_lbr_init_snb();
  4818	
  4819			x86_pmu.event_constraints = intel_ivb_event_constraints;
  4820			x86_pmu.pebs_constraints = intel_ivb_pebs_event_constraints;
  4821			x86_pmu.pebs_aliases = intel_pebs_aliases_ivb;
  4822			x86_pmu.pebs_prec_dist = true;
  4823			if (boot_cpu_data.x86_model == INTEL_FAM6_IVYBRIDGE_X)
  4824				x86_pmu.extra_regs = intel_snbep_extra_regs;
  4825			else
  4826				x86_pmu.extra_regs = intel_snb_extra_regs;
  4827			/* all extra regs are per-cpu when HT is on */
  4828			x86_pmu.flags |= PMU_FL_HAS_RSP_1;
  4829			x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
  4830	
  4831			td_attr  = snb_events_attrs;
  4832			mem_attr = snb_mem_events_attrs;
  4833	
  4834			/* UOPS_ISSUED.ANY,c=1,i=1 to count stall cycles */
  4835			intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
  4836				X86_CONFIG(.event=0x0e, .umask=0x01, .inv=1, .cmask=1);
  4837	
  4838			extra_attr = nhm_format_attr;
  4839	
  4840			pr_cont("IvyBridge events, ");
  4841			name = "ivybridge";
  4842			break;
  4843	
  4844	
  4845		case INTEL_FAM6_HASWELL_CORE:
  4846		case INTEL_FAM6_HASWELL_X:
  4847		case INTEL_FAM6_HASWELL_ULT:
  4848		case INTEL_FAM6_HASWELL_GT3E:
  4849			x86_add_quirk(intel_ht_bug);
  4850			x86_add_quirk(intel_pebs_isolation_quirk);
  4851			x86_pmu.late_ack = true;
  4852			memcpy(hw_cache_event_ids, hsw_hw_cache_event_ids, sizeof(hw_cache_event_ids));
  4853			memcpy(hw_cache_extra_regs, hsw_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
  4854	
  4855			intel_pmu_lbr_init_hsw();
  4856	
  4857			x86_pmu.event_constraints = intel_hsw_event_constraints;
  4858			x86_pmu.pebs_constraints = intel_hsw_pebs_event_constraints;
  4859			x86_pmu.extra_regs = intel_snbep_extra_regs;
  4860			x86_pmu.pebs_aliases = intel_pebs_aliases_ivb;
  4861			x86_pmu.pebs_prec_dist = true;
  4862			/* all extra regs are per-cpu when HT is on */
  4863			x86_pmu.flags |= PMU_FL_HAS_RSP_1;
  4864			x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
  4865	
  4866			x86_pmu.hw_config = hsw_hw_config;
  4867			x86_pmu.get_event_constraints = hsw_get_event_constraints;
  4868			x86_pmu.lbr_double_abort = true;
  4869			extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
  4870				hsw_format_attr : nhm_format_attr;
  4871			td_attr  = hsw_events_attrs;
  4872			mem_attr = hsw_mem_events_attrs;
  4873			tsx_attr = hsw_tsx_events_attrs;
  4874			pr_cont("Haswell events, ");
  4875			name = "haswell";
  4876			break;
  4877	
  4878		case INTEL_FAM6_BROADWELL_CORE:
  4879		case INTEL_FAM6_BROADWELL_XEON_D:
  4880		case INTEL_FAM6_BROADWELL_GT3E:
  4881		case INTEL_FAM6_BROADWELL_X:
  4882			x86_add_quirk(intel_pebs_isolation_quirk);
  4883			x86_pmu.late_ack = true;
  4884			memcpy(hw_cache_event_ids, hsw_hw_cache_event_ids, sizeof(hw_cache_event_ids));
  4885			memcpy(hw_cache_extra_regs, hsw_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
  4886	
  4887			/* L3_MISS_LOCAL_DRAM is BIT(26) in Broadwell */
  4888			hw_cache_extra_regs[C(LL)][C(OP_READ)][C(RESULT_MISS)] = HSW_DEMAND_READ |
  4889										 BDW_L3_MISS|HSW_SNOOP_DRAM;
  4890			hw_cache_extra_regs[C(LL)][C(OP_WRITE)][C(RESULT_MISS)] = HSW_DEMAND_WRITE|BDW_L3_MISS|
  4891										  HSW_SNOOP_DRAM;
  4892			hw_cache_extra_regs[C(NODE)][C(OP_READ)][C(RESULT_ACCESS)] = HSW_DEMAND_READ|
  4893										     BDW_L3_MISS_LOCAL|HSW_SNOOP_DRAM;
  4894			hw_cache_extra_regs[C(NODE)][C(OP_WRITE)][C(RESULT_ACCESS)] = HSW_DEMAND_WRITE|
  4895										      BDW_L3_MISS_LOCAL|HSW_SNOOP_DRAM;
  4896	
  4897			intel_pmu_lbr_init_hsw();
  4898	
  4899			x86_pmu.event_constraints = intel_bdw_event_constraints;
  4900			x86_pmu.pebs_constraints = intel_bdw_pebs_event_constraints;
  4901			x86_pmu.extra_regs = intel_snbep_extra_regs;
  4902			x86_pmu.pebs_aliases = intel_pebs_aliases_ivb;
  4903			x86_pmu.pebs_prec_dist = true;
  4904			/* all extra regs are per-cpu when HT is on */
  4905			x86_pmu.flags |= PMU_FL_HAS_RSP_1;
  4906			x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
  4907	
  4908			x86_pmu.hw_config = hsw_hw_config;
  4909			x86_pmu.get_event_constraints = hsw_get_event_constraints;
  4910			x86_pmu.limit_period = bdw_limit_period;
  4911			extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
  4912				hsw_format_attr : nhm_format_attr;
  4913			td_attr  = hsw_events_attrs;
  4914			mem_attr = hsw_mem_events_attrs;
  4915			tsx_attr = hsw_tsx_events_attrs;
  4916			pr_cont("Broadwell events, ");
  4917			name = "broadwell";
  4918			break;
  4919	
  4920		case INTEL_FAM6_XEON_PHI_KNL:
  4921		case INTEL_FAM6_XEON_PHI_KNM:
  4922			memcpy(hw_cache_event_ids,
  4923			       slm_hw_cache_event_ids, sizeof(hw_cache_event_ids));
  4924			memcpy(hw_cache_extra_regs,
  4925			       knl_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
  4926			intel_pmu_lbr_init_knl();
  4927	
  4928			x86_pmu.event_constraints = intel_slm_event_constraints;
  4929			x86_pmu.pebs_constraints = intel_slm_pebs_event_constraints;
  4930			x86_pmu.extra_regs = intel_knl_extra_regs;
  4931	
  4932			/* all extra regs are per-cpu when HT is on */
  4933			x86_pmu.flags |= PMU_FL_HAS_RSP_1;
  4934			x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
  4935			extra_attr = slm_format_attr;
  4936			pr_cont("Knights Landing/Mill events, ");
  4937			name = "knights-landing";
  4938			break;
  4939	
  4940		case INTEL_FAM6_SKYLAKE_X:
  4941			pmem = true;
  4942		case INTEL_FAM6_SKYLAKE_MOBILE:
  4943		case INTEL_FAM6_SKYLAKE_DESKTOP:
  4944		case INTEL_FAM6_KABYLAKE_MOBILE:
  4945		case INTEL_FAM6_KABYLAKE_DESKTOP:
  4946			x86_add_quirk(intel_pebs_isolation_quirk);
  4947			x86_pmu.late_ack = true;
  4948			memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
  4949			memcpy(hw_cache_extra_regs, skl_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
  4950			intel_pmu_lbr_init_skl();
  4951	
  4952			/* INT_MISC.RECOVERY_CYCLES has umask 1 in Skylake */
  4953			event_attr_td_recovery_bubbles.event_str_noht =
  4954				"event=0xd,umask=0x1,cmask=1";
  4955			event_attr_td_recovery_bubbles.event_str_ht =
  4956				"event=0xd,umask=0x1,cmask=1,any=1";
  4957	
  4958			x86_pmu.event_constraints = intel_skl_event_constraints;
  4959			x86_pmu.pebs_constraints = intel_skl_pebs_event_constraints;
  4960			x86_pmu.extra_regs = intel_skl_extra_regs;
  4961			x86_pmu.pebs_aliases = intel_pebs_aliases_skl;
  4962			x86_pmu.pebs_prec_dist = true;
  4963			/* all extra regs are per-cpu when HT is on */
  4964			x86_pmu.flags |= PMU_FL_HAS_RSP_1;
  4965			x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
  4966	
  4967			x86_pmu.hw_config = hsw_hw_config;
  4968			x86_pmu.get_event_constraints = hsw_get_event_constraints;
  4969			extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
  4970				hsw_format_attr : nhm_format_attr;
  4971			extra_skl_attr = skl_format_attr;
  4972			td_attr  = hsw_events_attrs;
  4973			mem_attr = hsw_mem_events_attrs;
  4974			tsx_attr = hsw_tsx_events_attrs;
  4975			intel_pmu_pebs_data_source_skl(pmem);
  4976	
  4977			if (boot_cpu_has(X86_FEATURE_TSX_FORCE_ABORT)) {
  4978				x86_pmu.flags |= PMU_FL_TFA;
  4979				x86_pmu.get_event_constraints = tfa_get_event_constraints;
  4980				x86_pmu.enable_all = intel_tfa_pmu_enable_all;
  4981				x86_pmu.commit_scheduling = intel_tfa_commit_scheduling;
  4982				intel_pmu_attrs[1] = &dev_attr_allow_tsx_force_abort.attr;
  4983			}
  4984	
  4985			pr_cont("Skylake events, ");
  4986			name = "skylake";
  4987			break;
  4988	
> 4989		case INTEL_FAM6_ICELAKE_X:
> 4990		case INTEL_FAM6_ICELAKE_XEON_D:
  4991			pmem = true;
  4992		case INTEL_FAM6_ICELAKE_MOBILE:
  4993		case INTEL_FAM6_ICELAKE_DESKTOP:
  4994			x86_pmu.late_ack = true;
  4995			memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
  4996			memcpy(hw_cache_extra_regs, skl_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
  4997			hw_cache_event_ids[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)] = -1;
  4998			intel_pmu_lbr_init_skl();
  4999	
  5000			x86_pmu.event_constraints = intel_icl_event_constraints;
  5001			x86_pmu.pebs_constraints = intel_icl_pebs_event_constraints;
  5002			x86_pmu.extra_regs = intel_icl_extra_regs;
  5003			x86_pmu.pebs_aliases = NULL;
  5004			x86_pmu.pebs_prec_dist = true;
  5005			x86_pmu.flags |= PMU_FL_HAS_RSP_1;
  5006			x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
  5007	
  5008			x86_pmu.hw_config = hsw_hw_config;
  5009			x86_pmu.get_event_constraints = icl_get_event_constraints;
  5010			extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
  5011				hsw_format_attr : nhm_format_attr;
  5012			extra_skl_attr = skl_format_attr;
  5013			mem_attr = icl_events_attrs;
  5014			tsx_attr = icl_tsx_events_attrs;
  5015			x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xca, .umask=0x02);
  5016			x86_pmu.lbr_pt_coexist = true;
  5017			intel_pmu_pebs_data_source_skl(pmem);
  5018			pr_cont("Icelake events, ");
  5019			name = "icelake";
  5020			break;
  5021	
  5022		default:
  5023			switch (x86_pmu.version) {
  5024			case 1:
  5025				x86_pmu.event_constraints = intel_v1_event_constraints;
  5026				pr_cont("generic architected perfmon v1, ");
  5027				name = "generic_arch_v1";
  5028				break;
  5029			default:
  5030				/*
  5031				 * default constraints for v2 and up
  5032				 */
  5033				x86_pmu.event_constraints = intel_gen_event_constraints;
  5034				pr_cont("generic architected perfmon, ");
  5035				name = "generic_arch_v2+";
  5036				break;
  5037			}
  5038		}
  5039	
  5040		snprintf(pmu_name_str, sizeof(pmu_name_str), "%s", name);
  5041	
  5042	
  5043		group_events_td.attrs  = td_attr;
  5044		group_events_mem.attrs = mem_attr;
  5045		group_events_tsx.attrs = tsx_attr;
  5046		group_format_extra.attrs = extra_attr;
  5047		group_format_extra_skl.attrs = extra_skl_attr;
  5048	
  5049		x86_pmu.attr_update = attr_update;
  5050	
  5051		if (x86_pmu.num_counters > INTEL_PMC_MAX_GENERIC) {
  5052			WARN(1, KERN_ERR "hw perf events %d > max(%d), clipping!",
  5053			     x86_pmu.num_counters, INTEL_PMC_MAX_GENERIC);
  5054			x86_pmu.num_counters = INTEL_PMC_MAX_GENERIC;
  5055		}
  5056		x86_pmu.intel_ctrl = (1ULL << x86_pmu.num_counters) - 1;
  5057	
  5058		if (x86_pmu.num_counters_fixed > INTEL_PMC_MAX_FIXED) {
  5059			WARN(1, KERN_ERR "hw perf events fixed %d > max(%d), clipping!",
  5060			     x86_pmu.num_counters_fixed, INTEL_PMC_MAX_FIXED);
  5061			x86_pmu.num_counters_fixed = INTEL_PMC_MAX_FIXED;
  5062		}
  5063	
  5064		x86_pmu.intel_ctrl |=
  5065			((1LL << x86_pmu.num_counters_fixed)-1) << INTEL_PMC_IDX_FIXED;
  5066	
  5067		if (x86_pmu.event_constraints) {
  5068			/*
  5069			 * event on fixed counter2 (REF_CYCLES) only works on this
  5070			 * counter, so do not extend mask to generic counters
  5071			 */
  5072			for_each_event_constraint(c, x86_pmu.event_constraints) {
  5073				if (c->cmask == FIXED_EVENT_FLAGS
  5074				    && c->idxmsk64 != INTEL_PMC_MSK_FIXED_REF_CYCLES) {
  5075					c->idxmsk64 |= (1ULL << x86_pmu.num_counters) - 1;
  5076				}
  5077				c->idxmsk64 &=
  5078					~(~0ULL << (INTEL_PMC_IDX_FIXED + x86_pmu.num_counters_fixed));
  5079				c->weight = hweight64(c->idxmsk64);
  5080			}
  5081		}
  5082	
  5083		/*
  5084		 * Access LBR MSR may cause #GP under certain circumstances.
  5085		 * E.g. KVM doesn't support LBR MSR
  5086		 * Check all LBT MSR here.
  5087		 * Disable LBR access if any LBR MSRs can not be accessed.
  5088		 */
  5089		if (x86_pmu.lbr_nr && !check_msr(x86_pmu.lbr_tos, 0x3UL))
  5090			x86_pmu.lbr_nr = 0;
  5091		for (i = 0; i < x86_pmu.lbr_nr; i++) {
  5092			if (!(check_msr(x86_pmu.lbr_from + i, 0xffffUL) &&
  5093			      check_msr(x86_pmu.lbr_to + i, 0xffffUL)))
  5094				x86_pmu.lbr_nr = 0;
  5095		}
  5096	
  5097		if (x86_pmu.lbr_nr)
  5098			pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
  5099	
  5100		/*
  5101		 * Access extra MSR may cause #GP under certain circumstances.
  5102		 * E.g. KVM doesn't support offcore event
  5103		 * Check all extra_regs here.
  5104		 */
  5105		if (x86_pmu.extra_regs) {
  5106			for (er = x86_pmu.extra_regs; er->msr; er++) {
  5107				er->extra_msr_access = check_msr(er->msr, 0x11UL);
  5108				/* Disable LBR select mapping */
  5109				if ((er->idx == EXTRA_REG_LBR) && !er->extra_msr_access)
  5110					x86_pmu.lbr_sel_map = NULL;
  5111			}
  5112		}
  5113	
  5114		/* Support full width counters using alternative MSR range */
  5115		if (x86_pmu.intel_cap.full_width_write) {
  5116			x86_pmu.max_period = x86_pmu.cntval_mask >> 1;
  5117			x86_pmu.perfctr = MSR_IA32_PMC0;
  5118			pr_cont("full-width counters, ");
  5119		}
  5120	
  5121		/*
  5122		 * For arch perfmon 4 use counter freezing to avoid
  5123		 * several MSR accesses in the PMI.
  5124		 */
  5125		if (x86_pmu.counter_freezing)
  5126			x86_pmu.handle_irq = intel_pmu_handle_irq_v4;
  5127	
  5128		return 0;
  5129	}
  5130	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--6c2NcOVqGQ03X4Wi
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
DHMD6by1shKbiRuECf//ecCosor+AgA=

--6c2NcOVqGQ03X4Wi--
