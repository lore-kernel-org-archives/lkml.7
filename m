Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44C8ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93A4206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732298AbfJIRcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:32:22 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:53030 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731901AbfJIRcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:32:20 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46pLrL04G5z1rqSZ;
        Wed,  9 Oct 2019 19:32:17 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46pLrK0DR6z1qqkQ;
        Wed,  9 Oct 2019 19:32:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id l80dbBGTn2J7; Wed,  9 Oct 2019 19:32:16 +0200 (CEST)
X-Auth-Info: /7eABWXbI0RPW7CdzoEHdo7a5y0u4TYQb2jLxJ1Ts0Dsl0C17k5BT8IcnhnVMxYN
Received: from igel.home (ppp-46-244-190-21.dynamic.mnet-online.de [46.244.190.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed,  9 Oct 2019 19:32:16 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 834F92C2277; Wed,  9 Oct 2019 19:32:15 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Dmitry Goldin <dgoldin@protonmail.ch>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel\\\\\\\\\@vger.kernel.org" 
        <linux-kernel@vger.kernel.org>,
        "joel\\\\\\\\\@joelfernandes.org" <joel@joelfernandes.org>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH] kheaders: substituting --sort in archive creation
References: <oZ31wh8h96sDGJ_uQWJbvFDzh4-ByMMeoyOhTLmfdf5B5T0KWgLhhNbC49J6EM_Nlgo_zH-bUScrWxYTgP9eNNMF1D5AbpcbIHbBuzbS_44=@protonmail.ch>
        <JhK61rXiXRkJbVJqHH9kRlLM_zO-J6fPM-NCa2P1eKSIfXzpunRtwJNMS4fliDWqMBhQKqp5t3fmUmKLhuSAeqTS6nVogdqnVyxagsH2z9M=@protonmail.ch>
X-Yow:  They don't hire PERSONAL PINHEADS, Mr. Toad!
Date:   Wed, 09 Oct 2019 19:32:15 +0200
In-Reply-To: <JhK61rXiXRkJbVJqHH9kRlLM_zO-J6fPM-NCa2P1eKSIfXzpunRtwJNMS4fliDWqMBhQKqp5t3fmUmKLhuSAeqTS6nVogdqnVyxagsH2z9M=@protonmail.ch>
        (Dmitry Goldin's message of "Wed, 09 Oct 2019 13:56:52 +0000")
Message-ID: <87eezlq0yo.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Okt 09 2019, Dmitry Goldin <dgoldin@protonmail.ch> wrote:

> Andreas: Could you give this patch a try and see if this works for you?

Thanks, works for me.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
