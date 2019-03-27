Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99687C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 04:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F9F2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 04:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfC0E36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 00:29:58 -0400
Received: from ozlabs.org ([203.11.71.1]:40545 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfC0E35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 00:29:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44TZm33hPQz9sSh;
        Wed, 27 Mar 2019 15:29:55 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
In-Reply-To: <20190326131550.GB10898@sirena.org.uk>
References: <20190326133349.3d9427dc@canb.auug.org.au> <20190326131550.GB10898@sirena.org.uk>
Date:   Wed, 27 Mar 2019 15:29:55 +1100
Message-ID: <87pnqdndmk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> writes:
> On Tue, Mar 26, 2019 at 01:33:49PM +1100, Stephen Rothwell wrote:
>
>> After merging the sound-asoc tree, today's linux-next build (powerpc
>> allyesconfig) failed like this:
>
>> sound/soc/codecs/tlv320aic32x4-clk.c: In function 'clk_aic32x4_pll_prepare':
>> include/linux/kernel.h:979:32: error: dereferencing pointer to incomplete type 'struct clk_hw'
>>   BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
>>                                 ^~~~~~
>
> Hrm, seems PowerPC is still not using the common clock API - is there
> any plan for that?  There are some ASoC PowerPC uses so it's going to be
> a bit of an issue as we expand our use of the clock API.

I don't know anything about the common clock API. What would it involve
for powerpc to use it?

cheers
