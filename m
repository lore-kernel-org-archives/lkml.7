Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0D4C31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 11:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A137C20866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 11:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfFOLXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 07:23:07 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:51724 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfFOLXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 07:23:06 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 45Qw7q0G5gz1rZmF;
        Sat, 15 Jun 2019 13:23:02 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 45Qw7p4wltz1qqkq;
        Sat, 15 Jun 2019 13:23:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 32iiHLIhpSjR; Sat, 15 Jun 2019 13:23:01 +0200 (CEST)
X-Auth-Info: ZW2m/EGMyMeBLGS0Jv0uhM66laTSzov2ePxmTnFUsajeafpbBnJm2jdBWQDlQcv6
Received: from igel.home (ppp-46-244-181-62.dynamic.mnet-online.de [46.244.181.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 15 Jun 2019 13:23:01 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 8A8E02C0C9A; Sat, 15 Jun 2019 13:23:00 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 13/16] powerpc/mm/32s: Use BATs for STRICT_KERNEL_RWX
References: <cover.1550775950.git.christophe.leroy@c-s.fr>
        <1e412310cc18ea654fb2ce4c935654d8d1069f27.1550775950.git.christophe.leroy@c-s.fr>
X-Yow:  SANTA CLAUS comes down a FIRE ESCAPE wearing bright
 blue LEG WARMERS..  He scrubs the POPE with a mild
 soap or detergent for 15 minutes, starring JANE FONDA!!
Date:   Sat, 15 Jun 2019 13:23:00 +0200
In-Reply-To: <1e412310cc18ea654fb2ce4c935654d8d1069f27.1550775950.git.christophe.leroy@c-s.fr>
        (Christophe Leroy's message of "Thu, 21 Feb 2019 19:08:49 +0000
        (UTC)")
Message-ID: <87blyz9jor.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This breaks suspend (or resume) on the iBook G4.  no_console_suspend
doesn't give any clues, the display just stays dark.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
