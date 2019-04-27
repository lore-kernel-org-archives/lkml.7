Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A29C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 14:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001ED2087F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 14:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556376113;
	bh=iPh/HmZEwEbH92s52aoXT/mortbs5izeBLnaOKHaSSA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mQZ9aJpUKuKANhTFlhwGf3pj7zPxB+fubgUWCwxr/GpN56O44E7d5DKIqS71fvjbw
	 +ANzsCcD4hNXMITJBY3xuvm1vT1Py0qYwZeIEylMJcqDcfdJTH1owlLEcm4f2wTKhs
	 SSgQ7tnNcjtv/6AjYY/psvIq0ufJi5jAQanmyBos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfD0Olv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 10:41:51 -0400
Received: from casper.infradead.org ([85.118.1.10]:42152 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0Olv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 10:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ws+mFvuDPU5R9sCajelbZqczWkg7DqO0k2aub68jS/w=; b=LBheJcgTsVav3/sVVHMZnvwgDS
        8HuwuyEvGpYwmDagSGn+LC87AVCp8q8N/aV2367cxyEsJaXxy8SHMWCzG1gwek/Ss2+JGKk3VLVd3
        AIJYf3tYNTsCyyNVc7A8Cxp48OiGgNfAW11n5tD4L6rVuW0oOOMmjcJeQmNlC3nStsBJDCoJNrucb
        hUAZ/FK36yI7kin6Gm3qA4I04F7nC35t6XX9fMrFPRWnPNVeDQvH9Kv8dkiaPU7aXeXQA/u7FMAqo
        5oe0zSOR2+gJo35/5qxMGSEiUWFkU1GuLkr5fG7FwvdauZgzdUUpe4H6ENE5rC3oCaKNm5oEFQS3S
        wTJ9+Qxg==;
Received: from 177.17.250.151.dynamic.adsl.gvt.net.br ([177.17.250.151] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hKOWO-0007f0-Ft; Sat, 27 Apr 2019 14:41:45 +0000
Date:   Sat, 27 Apr 2019 11:41:39 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/27] Documentation: x86: convert topology.txt to reST
Message-ID: <20190427114139.2a6c587c@coco.lan>
In-Reply-To: <20190426153150.21228-4-changbin.du@gmail.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
        <20190426153150.21228-4-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 26 Apr 2019 23:31:26 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  Documentation/x86/index.rst                   |  1 +
>  .../x86/{topology.txt => topology.rst}        | 92 ++++++++++---------
>  2 files changed, 49 insertions(+), 44 deletions(-)
>  rename Documentation/x86/{topology.txt => topology.rst} (74%)
> 
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> index 8f08caf4fbbb..2033791e53bc 100644
> --- a/Documentation/x86/index.rst
> +++ b/Documentation/x86/index.rst
> @@ -9,3 +9,4 @@ Linux x86 Support
>     :numbered:
>  
>     boot
> +   topology
> diff --git a/Documentation/x86/topology.txt b/Documentation/x86/topology.rst
> similarity index 74%
> rename from Documentation/x86/topology.txt
> rename to Documentation/x86/topology.rst
> index 2953e3ec9a02..5176e5315faa 100644
> --- a/Documentation/x86/topology.txt
> +++ b/Documentation/x86/topology.rst
> @@ -1,3 +1,6 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +============
>  x86 Topology
>  ============
>  
> @@ -33,14 +36,14 @@ The topology of a system is described in the units of:
>      - cores
>      - threads
>  
> -* Package:
> -
> -  Packages contain a number of cores plus shared resources, e.g. DRAM
> -  controller, shared caches etc.
> +Package
> +=======
> +Packages contain a number of cores plus shared resources, e.g. DRAM
> +controller, shared caches etc.
>  
> -  AMD nomenclature for package is 'Node'.
> +AMD nomenclature for package is 'Node'.
>  
> -  Package-related topology information in the kernel:
> +Package-related topology information in the kernel:
>  
>    - cpuinfo_x86.x86_max_cores:
>  
> @@ -66,40 +69,41 @@ The topology of a system is described in the units of:
>    - cpu_llc_id:
>  
>      A per-CPU variable containing:
> -    - On Intel, the first APIC ID of the list of CPUs sharing the Last Level
> -    Cache
>  
> -    - On AMD, the Node ID or Core Complex ID containing the Last Level
> -    Cache. In general, it is a number identifying an LLC uniquely on the
> -    system.
> +      - On Intel, the first APIC ID of the list of CPUs sharing the Last Level
> +        Cache
>  
> -* Cores:
> +      - On AMD, the Node ID or Core Complex ID containing the Last Level
> +        Cache. In general, it is a number identifying an LLC uniquely on the
> +        system.
>  
> -  A core consists of 1 or more threads. It does not matter whether the threads
> -  are SMT- or CMT-type threads.
> +Cores
> +=====
> +A core consists of 1 or more threads. It does not matter whether the threads
> +are SMT- or CMT-type threads.
>  
> -  AMDs nomenclature for a CMT core is "Compute Unit". The kernel always uses
> -  "core".
> +AMDs nomenclature for a CMT core is "Compute Unit". The kernel always uses
> +"core".
>  
> -  Core-related topology information in the kernel:
> +Core-related topology information in the kernel:
>  
>    - smp_num_siblings:
>  
>      The number of threads in a core. The number of threads in a package can be
> -    calculated by:
> +    calculated by::
>  
>  	threads_per_package = cpuinfo_x86.x86_max_cores * smp_num_siblings
>  
>  
> -* Threads:
> +Threads
> +=======
> +A thread is a single scheduling unit. It's the equivalent to a logical Linux
> +CPU.
>  
> -  A thread is a single scheduling unit. It's the equivalent to a logical Linux
> -  CPU.
> +AMDs nomenclature for CMT threads is "Compute Unit Core". The kernel always
> +uses "thread".
>  
> -  AMDs nomenclature for CMT threads is "Compute Unit Core". The kernel always
> -  uses "thread".
> -
> -  Thread-related topology information in the kernel:
> +Thread-related topology information in the kernel:
>  
>    - topology_core_cpumask():
>  
> @@ -113,15 +117,15 @@ The topology of a system is described in the units of:
>      The cpumask contains all online threads in the core to which a thread
>      belongs.
>  
> -   - topology_logical_package_id():
> +  - topology_logical_package_id():
>  
>      The logical package ID to which a thread belongs.
>  
> -   - topology_physical_package_id():
> +  - topology_physical_package_id():
>  
>      The physical package ID to which a thread belongs.
>  
> -   - topology_core_id();
> +  - topology_core_id();
>  
>      The ID of the core to which a thread belongs. It is also printed in /proc/cpuinfo
>      "core_id."
> @@ -129,41 +133,41 @@ The topology of a system is described in the units of:
>  
>  
>  System topology examples
> +========================
>  
> -Note:
> -
> -The alternative Linux CPU enumeration depends on how the BIOS enumerates the
> -threads. Many BIOSes enumerate all threads 0 first and then all threads 1.
> -That has the "advantage" that the logical Linux CPU numbers of threads 0 stay
> -the same whether threads are enabled or not. That's merely an implementation
> -detail and has no practical impact.
> +.. note::
> +  The alternative Linux CPU enumeration depends on how the BIOS enumerates the
> +  threads. Many BIOSes enumerate all threads 0 first and then all threads 1.
> +  That has the "advantage" that the logical Linux CPU numbers of threads 0 stay
> +  the same whether threads are enabled or not. That's merely an implementation
> +  detail and has no practical impact.
>  
> -1) Single Package, Single Core
> +1) Single Package, Single Core::
>  
>     [package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
>  
>  2) Single Package, Dual Core
>  
> -   a) One thread per core
> +   a) One thread per core::
>  
>  	[package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
>  		    -> [core 1] -> [thread 0] -> Linux CPU 1  
>  
> -   b) Two threads per core
> +   b) Two threads per core::
>  
>  	[package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
>  				-> [thread 1] -> Linux CPU 1
>  		    -> [core 1] -> [thread 0] -> Linux CPU 2
>  				-> [thread 1] -> Linux CPU 3  
>  
> -      Alternative enumeration:
> +      Alternative enumeration::
>  
>  	[package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
>  				-> [thread 1] -> Linux CPU 2
>  		    -> [core 1] -> [thread 0] -> Linux CPU 1
>  				-> [thread 1] -> Linux CPU 3  
>  
> -      AMD nomenclature for CMT systems:
> +      AMD nomenclature for CMT systems::
>  
>  	[node 0] -> [Compute Unit 0] -> [Compute Unit Core 0] -> Linux CPU 0
>  				     -> [Compute Unit Core 1] -> Linux CPU 1  
> @@ -172,7 +176,7 @@ detail and has no practical impact.
>  
>  4) Dual Package, Dual Core
>  
> -   a) One thread per core
> +   a) One thread per core::
>  
>  	[package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
>  		    -> [core 1] -> [thread 0] -> Linux CPU 1  
> @@ -180,7 +184,7 @@ detail and has no practical impact.
>  	[package 1] -> [core 0] -> [thread 0] -> Linux CPU 2
>  		    -> [core 1] -> [thread 0] -> Linux CPU 3  
>  
> -   b) Two threads per core
> +   b) Two threads per core::
>  
>  	[package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
>  				-> [thread 1] -> Linux CPU 1  
> @@ -192,7 +196,7 @@ detail and has no practical impact.
>  		    -> [core 1] -> [thread 0] -> Linux CPU 6
>  				-> [thread 1] -> Linux CPU 7  
>  
> -      Alternative enumeration:
> +      Alternative enumeration::
>  
>  	[package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
>  				-> [thread 1] -> Linux CPU 4  
> @@ -204,7 +208,7 @@ detail and has no practical impact.
>  		    -> [core 1] -> [thread 0] -> Linux CPU 3
>  				-> [thread 1] -> Linux CPU 7  
>  
> -      AMD nomenclature for CMT systems:
> +      AMD nomenclature for CMT systems::
>  
>  	[node 0] -> [Compute Unit 0] -> [Compute Unit Core 0] -> Linux CPU 0
>  				     -> [Compute Unit Core 1] -> Linux CPU 1  



Thanks,
Mauro
