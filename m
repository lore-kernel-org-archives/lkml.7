Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69D5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC922075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfCRJzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:55:05 -0400
Received: from ozlabs.org ([203.11.71.1]:55485 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727418AbfCRJzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:55:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44NBPK6j9Tz9s5c;
        Mon, 18 Mar 2019 20:55:01 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Guenter Roeck <linux@roeck-us.net>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/6xx: fix setup and use of SPRN_PGDIR for hash32
In-Reply-To: <fac535c2-af61-1a1b-ebed-82ca0bd2e4a4@roeck-us.net>
References: <7e45ca3f0283fb24c2642e5b91bd75c55f2ba96f.1552028583.git.christophe.leroy@c-s.fr> <20190308160334.GZ3969@gate.crashing.org> <7681ad2b-35d4-6e43-f727-21545e3bb223@c-s.fr> <72bac00c-d2e3-515e-3ab1-99f20c058ea1@c-s.fr> <fac535c2-af61-1a1b-ebed-82ca0bd2e4a4@roeck-us.net>
Date:   Mon, 18 Mar 2019 20:54:58 +1100
Message-ID: <87muls7bil.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> writes:
> On 3/15/19 6:20 AM, Christophe Leroy wrote:
>> Michael,
>> 
>> Are you able to get this merged before 5.1-rc1 comes out ?
>
> Looks like this patch got lost. I don't see it in Michael's most recent
> pull request, the one that got merged today.

Sorry, will pick it up for fixes now.

cheers
