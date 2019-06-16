Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09ABC31E49
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 10:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEF32084A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 10:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfFPKNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 06:13:24 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:52449 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfFPKNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 06:13:23 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 45RVXy03QRz1rGhP;
        Sun, 16 Jun 2019 12:13:22 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 45RVXx6V0rz1qql1;
        Sun, 16 Jun 2019 12:13:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id MOFsqklPMlpF; Sun, 16 Jun 2019 12:13:21 +0200 (CEST)
X-Auth-Info: cmuhtM6YUgJKHIsEcEpVlxTl8g7MpYPHC7rEiFby6sTT4CK1ale7h5rnC6HpCSiD
Received: from igel.home (ppp-46-244-189-62.dynamic.mnet-online.de [46.244.189.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 16 Jun 2019 12:13:21 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 748632C117A; Sun, 16 Jun 2019 12:13:20 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     christophe leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 13/16] powerpc/mm/32s: Use BATs for STRICT_KERNEL_RWX
References: <cover.1550775950.git.christophe.leroy@c-s.fr>
        <1e412310cc18ea654fb2ce4c935654d8d1069f27.1550775950.git.christophe.leroy@c-s.fr>
        <87blyz9jor.fsf@igel.home>
        <a76f7759-a407-3d9a-0f43-654fd7ea0b1e@c-s.fr>
X-Yow:  Yow!
Date:   Sun, 16 Jun 2019 12:13:20 +0200
In-Reply-To: <a76f7759-a407-3d9a-0f43-654fd7ea0b1e@c-s.fr> (christophe leroy's
        message of "Sun, 16 Jun 2019 10:20:29 +0200")
Message-ID: <87d0jdaldr.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 16 2019, christophe leroy <christophe.leroy@c-s.fr> wrote:

> If any of registers IBATs 4 to 7 are used, could you adjust
> CONFIG_ETEXT_SHIFT so that only IBATs 0 to 3 be used, and check if
> suspend/resume works when IBATs 4 to 7 are not used ?

I forgot to remove my patch.  With only 0-3 used, suspend/resume works.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
