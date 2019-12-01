Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82432C432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 16:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BA02082E
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 16:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575216638;
	bh=PIU0gAvAb/QWpkQDN6LuCKXuN8ggEJbi00MqgS1d1rk=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ZdyUoeKU60/H4nTR1mY0/k44I4VALKFNev47jvQr39sWfJbhYwjdgyiKmJCLpf6zS
	 3oIb/TnekIZCQZVhMMUyPfEfitLl17cBTZAmtjY9Rla5qp8cSrr4+crfTo0K3TVWLW
	 N1ThoPLPFaQzB+36Y8GHHtXC+wjxtOhUcMwzFqOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfLAQKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 11:10:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfLAQKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 11:10:36 -0500
Received: from [192.168.1.20] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7172A20748;
        Sun,  1 Dec 2019 16:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575216636;
        bh=PIU0gAvAb/QWpkQDN6LuCKXuN8ggEJbi00MqgS1d1rk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LStGGO3Bn5iRhOvss1QFFXvjhAfoOmrJMzZm1wop7NFIKGOSDfpaaEIBb0wtVnunz
         lcq1VMGCc9awJ9EP9VTCCMWg2YMkMLk8TuPbG+sMKCtRQhoanbfeGb7tU4K56taoS/
         zsiYMFnTAlobLfu7PZEnng+hNHAhRz8UWdJ61pc8=
Subject: Re: [PATCH v6 00/49] QUICC Engine support on ARM, ARM64, PPC64
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <7beef282-1dd8-7c7a-4f6d-d0605d11eab5@kernel.org>
Date:   Sun, 1 Dec 2019 10:10:30 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/19 8:55 AM, Rasmus Villemoes wrote:
> There have been several attempts in the past few years to allow
> building the QUICC engine drivers for platforms other than PPC32. This
> is yet another attempt.
> 
> v5 can be found here:https://lore.kernel.org/lkml/20191118112324.22725-1-linux@rasmusvillemoes.dk/

If it helps:

Entire series:
Acked-by: Timur Tabi <timur@kernel.org>

I've worked on all code covered by this patchset except for the hdlc 
driver.  I don't know if my ACKs are acceptable to everyone, but you 
have them regardless.
