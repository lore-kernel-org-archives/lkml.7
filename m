Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AF4C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983BF20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732274AbfDBNuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:50:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:60762 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731136AbfDBNuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:50:10 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 06:50:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,300,1549958400"; 
   d="scan'208";a="158031336"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.107])
  by fmsmga004.fm.intel.com with ESMTP; 02 Apr 2019 06:50:05 -0700
Date:   Tue, 2 Apr 2019 21:50:30 +0800
From:   Rong Chen <rong.a.chen@intel.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2019.03.20b 54/83]
 drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:50:1: error: type
 defaults to 'int' in declaration of 'DEFINE_SRCU'
Message-ID: <20190402135030.GD20952@shao2-debian>
References: <201903250225.RRMwkT3f%lkp@intel.com>
 <20190327195726.GF4102@linux.ibm.com>
 <cad8bc52-a3ab-0d4e-bb13-c436510f684b@intel.com>
 <20190402130424.GU4102@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190402130424.GU4102@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 06:04:24AM -0700, Paul E. McKenney wrote:
> On Tue, Apr 02, 2019 at 08:32:45AM +0800, Rong Chen wrote:
> > 
> > On 3/28/19 3:57 AM, Paul E. McKenney wrote:
> > >On Mon, Mar 25, 2019 at 02:34:27AM +0800, kbuild test robot wrote:
> > >>tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2019.03.20b
> > >>head:   6d4434b4b4df791620743178e1419de882b44c7b
> > >>commit: eb89abcb30733e3a2343dda23cb6d81cc17c60b3 [54/83] rcu: Forbid DEFINE{,_STATIC}_SRCU() from modules
> > >>config: x86_64-randconfig-b0-03250021 (attached as .config)
> > >>compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> > >>reproduce:
> > >>         git checkout eb89abcb30733e3a2343dda23cb6d81cc17c60b3
> > >>         # save the attached .config to linux build tree
> > >>         make ARCH=x86_64
> > >>
> > >>All errors (new ones prefixed by >>):
> > >>
> > >>    drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:50:1: warning: data definition has no type or storage class
> > >>     DEFINE_SRCU(kfd_processes_srcu);
> > >>     ^~~~~~~~~~~
> > >>>>drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:50:1: error: type defaults to 'int' in declaration of 'DEFINE_SRCU' [-Werror=implicit-int]
> > >>    drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:50:1: warning: parameter names (without types) in function declaration
> > >>    cc1: some warnings being treated as errors
> > >I don't have that hardware, but does the following help?  (It at least
> > >builds for me, but your mileage may vary.)
> > 
> > Yes, the patch works for kbuild robot.
> 
> Thank you very much!  May I add your Tested-by?

Sure, please feel free to add it.

Thanks,
Rong Chen

> 
> 							Thanx, Paul
> 
> > Thanks,
> > Rong Chen
> > 
> > 
> > >
> > >------------------------------------------------------------------------
> > >
> > >commit b30be5a76070402912437fa23b43de11cb1973f4
> > >Author: Paul E. McKenney <paulmck@linux.ibm.com>
> > >Date:   Wed Mar 27 12:53:36 2019 -0700
> > >
> > >     drivers/gpu/drm/amd: Dynamically allocate kfd_processes_srcu
> > >     Having DEFINE_SRCU() or DEFINE_STATIC_SRCU() in a loadable module
> > >     requires that the size of the reserved region be increased, which is
> > >     not something we really want to be doing.  This commit therefore removes
> > >     the DEFINE_STATIC_SRCU() from drivers/gpu/drm/amd/amdkfd/kfd_process.c in
> > >     favor of defining kfd_processes_srcu as a simple srcu_struct, initializing
> > >     it in amdgpu_amdkfd_init(), and cleaning it up in amdgpu_amdkfd_fini().
> > >     Reported-by: kbuild test robot <lkp@intel.com>
> > >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > >     Cc: Oded Gabbay <oded.gabbay@gmail.com>
> > >     Cc: Alex Deucher <alexander.deucher@amd.com>
> > >     Cc: "Christian König" <christian.koenig@amd.com
> > >     Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>
> > >     Cc: David Airlie <airlied@linux.ie>
> > >     Cc: Daniel Vetter <daniel@ffwll.ch>
> > >
> > >diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > >index fe1d7368c1e6..eadb20dee867 100644
> > >--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > >+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > >@@ -28,6 +28,8 @@
> > >  #include <linux/module.h>
> > >  #include <linux/dma-buf.h>
> > >+extern struct srcu_struct kfd_processes_srcu;
> > >+
> > >  static const unsigned int compute_vmid_bitmap = 0xFF00;
> > >  /* Total memory size in system memory and all GPU VRAM. Used to
> > >@@ -40,6 +42,8 @@ int amdgpu_amdkfd_init(void)
> > >  	struct sysinfo si;
> > >  	int ret;
> > >+	ret = init_srcu_struct(&kfd_processes_srcu);
> > >+	WARN_ON(ret);
> > >  	si_meminfo(&si);
> > >  	amdgpu_amdkfd_total_mem_size = si.totalram - si.totalhigh;
> > >  	amdgpu_amdkfd_total_mem_size *= si.mem_unit;
> > >@@ -57,6 +61,7 @@ int amdgpu_amdkfd_init(void)
> > >  void amdgpu_amdkfd_fini(void)
> > >  {
> > >  	kgd2kfd_exit();
> > >+	cleanup_srcu_struct(&kfd_processes_srcu);
> > >  }
> > >  void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev)
> > >diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > >index 4bdae78bab8e..98b694068b8a 100644
> > >--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > >+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > >@@ -47,7 +47,7 @@ struct mm_struct;
> > >  DEFINE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
> > >  static DEFINE_MUTEX(kfd_processes_mutex);
> > >-DEFINE_SRCU(kfd_processes_srcu);
> > >+struct srcu_struct kfd_processes_srcu;
> > >  /* For process termination handling */
> > >  static struct workqueue_struct *kfd_process_wq;
> > >
> > 
> 
