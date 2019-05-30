Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF48DC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3ED925E3D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfE3RWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 13:22:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726538AbfE3RWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 13:22:41 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UHMbEj078678
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 13:22:40 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sthh558p2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 13:22:39 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 18:22:38 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 18:22:36 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UHLKLf43319380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 17:21:20 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59079B2064;
        Thu, 30 May 2019 17:21:20 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CEEAB2065;
        Thu, 30 May 2019 17:21:20 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 17:21:20 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1A01016C5D7E; Thu, 30 May 2019 10:21:22 -0700 (PDT)
Date:   Thu, 30 May 2019 10:21:22 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:test 69/69] arch/x86/include/asm/irqflags.h:41:2: warning:
 'flags' may be used uninitialized in this function
Reply-To: paulmck@linux.ibm.com
References: <201905310055.7eYmYEK8%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201905310055.7eYmYEK8%lkp@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19053017-0060-0000-0000-0000034A0372
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011185; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210833; UDB=6.00636186; IPR=6.00991867;
 MB=3.00027121; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 17:22:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053017-0061-0000-0000-0000498E449D
Message-Id: <20190530172122.GE28207@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 12:35:01AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git test
> head:   685a26bc60076305987bf06cfd1269e5e4094c73
> commit: 685a26bc60076305987bf06cfd1269e5e4094c73 [69/69] rcu/nocb: Avoid ->nocb_lock capture by corresponding CPU
> config: x86_64-randconfig-x009-201921 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         git checkout 685a26bc60076305987bf06cfd1269e5e4094c73
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

This is a false positive.  The return value of rcu_segcblist_is_offloaded()
for a given CPU cannot change post-boot.  (Famous last words!)

								Thanx, Paul

> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/irqflags.h:16:0,
>                     from arch/x86/include/asm/processor.h:33,
>                     from arch/x86/include/asm/cpufeature.h:5,
>                     from arch/x86/include/asm/thread_info.h:53,
>                     from include/linux/thread_info.h:38,
>                     from arch/x86/include/asm/preempt.h:7,
>                     from include/linux/preempt.h:78,
>                     from include/linux/spinlock.h:51,
>                     from kernel/rcu/tree.c:23:
>    kernel/rcu/tree_plugin.h: In function 'rcu_nocb_gp_kthread':
> >> arch/x86/include/asm/irqflags.h:41:2: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]
>      asm volatile("push %0 ; popf"
>      ^~~
>    In file included from kernel/rcu/tree.c:3519:0:
>    kernel/rcu/tree_plugin.h:1719:16: note: 'flags' was declared here
>      unsigned long flags;
>                    ^~~~~
>    kernel/rcu/tree_plugin.h: In function 'do_nocb_deferred_wakeup_common':
>    kernel/rcu/tree_plugin.h:1891:2: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]
>      wake_nocb_gp(rdp, ndw == RCU_NOCB_WAKE_FORCE, flags);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> --
>    In file included from include/linux/irqflags.h:16:0,
>                     from arch/x86/include/asm/processor.h:33,
>                     from arch/x86/include/asm/cpufeature.h:5,
>                     from arch/x86/include/asm/thread_info.h:53,
>                     from include/linux/thread_info.h:38,
>                     from arch/x86/include/asm/preempt.h:7,
>                     from include/linux/preempt.h:78,
>                     from include/linux/spinlock.h:51,
>                     from kernel//rcu/tree.c:23:
>    kernel//rcu/tree_plugin.h: In function 'rcu_nocb_gp_kthread':
> >> arch/x86/include/asm/irqflags.h:41:2: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]
>      asm volatile("push %0 ; popf"
>      ^~~
>    In file included from kernel//rcu/tree.c:3519:0:
>    kernel//rcu/tree_plugin.h:1719:16: note: 'flags' was declared here
>      unsigned long flags;
>                    ^~~~~
>    kernel//rcu/tree_plugin.h: In function 'do_nocb_deferred_wakeup_common':
>    kernel//rcu/tree_plugin.h:1891:2: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]
>      wake_nocb_gp(rdp, ndw == RCU_NOCB_WAKE_FORCE, flags);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> vim +/flags +41 arch/x86/include/asm/irqflags.h
> 
> 6abcd98f include/asm-x86/irqflags.h      Glauber de Oliveira Costa 2008-01-30  37  
> 1f59a458 arch/x86/include/asm/irqflags.h Nick Desaulniers          2018-08-27  38  extern inline void native_restore_fl(unsigned long flags);
> 1f59a458 arch/x86/include/asm/irqflags.h Nick Desaulniers          2018-08-27  39  extern inline void native_restore_fl(unsigned long flags)
> 6abcd98f include/asm-x86/irqflags.h      Glauber de Oliveira Costa 2008-01-30  40  {
> cf7f7191 include/asm-x86/irqflags.h      Joe Perches               2008-03-23 @41  	asm volatile("push %0 ; popf"
> 6abcd98f include/asm-x86/irqflags.h      Glauber de Oliveira Costa 2008-01-30  42  		     : /* no output */
> 6abcd98f include/asm-x86/irqflags.h      Glauber de Oliveira Costa 2008-01-30  43  		     :"g" (flags)
> cf7f7191 include/asm-x86/irqflags.h      Joe Perches               2008-03-23  44  		     :"memory", "cc");
> 6abcd98f include/asm-x86/irqflags.h      Glauber de Oliveira Costa 2008-01-30  45  }
> 6abcd98f include/asm-x86/irqflags.h      Glauber de Oliveira Costa 2008-01-30  46  
> 
> :::::: The code at line 41 was first introduced by commit
> :::::: cf7f7191cf20011e47243b594e433275a6db811b include/asm-x86/irqflags.h: checkpatch cleanups - formatting only
> 
> :::::: TO: Joe Perches <joe@perches.com>
> :::::: CC: Ingo Molnar <mingo@elte.hu>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


