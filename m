Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE50AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A9B2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfCTMw5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:52:57 -0400
Received: from ozlabs.org ([203.11.71.1]:33255 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfCTMw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:52:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44PVFg1bDqz9sPC;
        Wed, 20 Mar 2019 23:52:55 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Mathieu Malaterre <malat@debian.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: Make some functions static
In-Reply-To: <CA+7wUszPviAFVjyU-=qAJfOpe_NxmimWd2-tc148NLUEc4Oj0w@mail.gmail.com>
References: <20190312203140.31785-1-malat@debian.org> <607b412d-e5a2-5d08-7fb9-53a24e6c76d4@c-s.fr> <CA+7wUszPviAFVjyU-=qAJfOpe_NxmimWd2-tc148NLUEc4Oj0w@mail.gmail.com>
Date:   Wed, 20 Mar 2019 23:52:53 +1100
Message-ID: <87tvfxyafu.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Malaterre <malat@debian.org> writes:
> On Tue, Mar 12, 2019 at 10:14 PM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>>
>>
>>
>> Le 12/03/2019 à 21:31, Mathieu Malaterre a écrit :
>> > In commit cb9e4d10c448 ("[POWERPC] Add support for 750CL Holly board")
>> > new functions were added. Since these functions can be made static,
>> > make it so. While doing so, it turns out that holly_power_off and
>> > holly_halt are unused, so remove them.
>>
>> I would have said 'since these functions are only used in this C file,
>> make them static'.
>>
>> I think this could be split in two patches:
>> 1/ Remove unused functions, ie holly_halt() and holly_power_off().
>> 2/ Make the other ones static.
>
> Michael do you want two patches ?

That would be better if it's not too much trouble. A patch with a title
of "Make some functions static" shouldn't really be deleting functions
entirely.

cheers
