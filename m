Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CED2C04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A47520644
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfEIOwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 10:52:10 -0400
Received: from ozlabs.org ([203.11.71.1]:41961 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfEIOwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 10:52:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 450GX673Z2z9s4V;
        Fri, 10 May 2019 00:52:06 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Borislav Petkov <bp@alien8.de>,
        Johannes Thumshirn <morbidrsa@gmail.com>
Cc:     linux-edac@vger.kernel.org, mchehab@kernel.org,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] EDAC, mpc85xx: Prevent building as a module
In-Reply-To: <20190508101238.GB19015@zn.tnic>
References: <20190502141941.12927-1-mpe@ellerman.id.au> <20190506065045.GA3901@x250> <20190508101238.GB19015@zn.tnic>
Date:   Fri, 10 May 2019 00:52:05 +1000
Message-ID: <87o94bvfxm.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:
> On Mon, May 06, 2019 at 08:50:45AM +0200, Johannes Thumshirn wrote:
>> Acked-by: Johannes Thumshirn <jth@kernel.org>
>
> Queued, thanks.

Thanks. It would be nice if you could send it as a fix for 5.2, it's the
last thing blocking one of my allmodconfig builds. But if you don't
think it qualifies as a fix that's fine too, it can wait.

cheers
