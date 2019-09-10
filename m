Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E820C49ED9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C4A206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393888AbfIJPMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 11:12:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:60999 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393861AbfIJPMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:12:18 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x8AFBrQS016611;
        Tue, 10 Sep 2019 10:11:53 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x8AFBqhw016608;
        Tue, 10 Sep 2019 10:11:52 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 10 Sep 2019 10:11:52 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] powerpc/kexec: move kexec files into a dedicated subdir.
Message-ID: <20190910151152.GV9749@gate.crashing.org>
References: <68d12eb0b815049049babc9be243ffd8521b48c7.1568127294.git.christophe.leroy@c-s.fr> <9019b24c1f6ed838550669135fcaa9493670e188.1568127294.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9019b24c1f6ed838550669135fcaa9493670e188.1568127294.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 02:55:27PM +0000, Christophe Leroy wrote:
> arch/powerpc/kernel/ contains 7 files dedicated to kexec.
> 
> Move them into a dedicated subdirectory.

>  arch/powerpc/kernel/{ => kexec}/ima_kexec.c        |  0
>  arch/powerpc/kernel/{ => kexec}/kexec_32.S         |  2 +-
>  arch/powerpc/kernel/{ => kexec}/kexec_elf_64.c     |  0
>  arch/powerpc/kernel/{ => kexec}/machine_kexec.c    |  0
>  arch/powerpc/kernel/{ => kexec}/machine_kexec_32.c |  0
>  arch/powerpc/kernel/{ => kexec}/machine_kexec_64.c |  0
>  .../kernel/{ => kexec}/machine_kexec_file_64.c     |  0

The filenames do not really need "kexec" in there anymore then?


Segher
