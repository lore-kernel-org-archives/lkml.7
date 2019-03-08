Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D42C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BE320868
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfCHQEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:04:46 -0500
Received: from gate.crashing.org ([63.228.1.57]:43824 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfCHQEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:04:45 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x28G3cb9027140;
        Fri, 8 Mar 2019 10:03:39 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x28G3ap8027139;
        Fri, 8 Mar 2019 10:03:36 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 8 Mar 2019 10:03:36 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Guenter Roeck <linux@roeck-us.net>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/6xx: fix setup and use of SPRN_PGDIR for hash32
Message-ID: <20190308160334.GZ3969@gate.crashing.org>
References: <7e45ca3f0283fb24c2642e5b91bd75c55f2ba96f.1552028583.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e45ca3f0283fb24c2642e5b91bd75c55f2ba96f.1552028583.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 07:05:22AM +0000, Christophe Leroy wrote:
> Not only the 603 but all 6xx need SPRN_PGDIR to be initialised at
> startup. This patch move it from __setup_cpu_603() to start_here()
> and __secondary_start(), close to the initialisation of SPRN_THREAD.

I thought you meant an SPR I did not know about.  But you just misspelled
SPRN_SPRG_PGDIR :-)


Segher
