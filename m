Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D55C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DD42073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573828350;
	bh=TAYLQOhUh8h/nx6QbmxUbjow7UiI6LrAdXaD68+uFvE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=WnRE6ReWVDbBbssAVZloMol+LRZXVzeGClJUpJ+UF3YQY36M0SQlmKQ/Ig79cOfJP
	 nOsiQF+E2MHwihX+dIIPfiBE2OcCA0HrLh9XG3B8jdHqGEYbp6A+E6eCt3cpmAvX10
	 C3vUdfjTpwYntZ7u3AUeo+Jy62UoZ+wKgoC8yXnw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfKOOc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:32:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:49460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbfKOOc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:32:29 -0500
Received: from [192.168.1.20] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6F4220733;
        Fri, 15 Nov 2019 14:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573828348;
        bh=TAYLQOhUh8h/nx6QbmxUbjow7UiI6LrAdXaD68+uFvE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QCc9FbnjyGGyKkCNbEVOPEZxP32m3xPd+mfiIWpYphzaBxg9RNGVPUg/1VfeNFDh9
         5f+B5udjGz7ePtloj37N5rCoqZPSoWg2T0NaFSV0Uc3NQkcJFXE2M080wtTJdHgLfj
         bwUP6Ul0Esu35Kov5IyJBDwk2KkA058sMZlbGsBw=
Subject: Re: [PATCH v4 46/47] net: ethernet: freescale: make UCC_GETH
 explicitly depend on PPC32
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Li Yang <leoyang.li@nxp.com>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Scott Wood <oss@buserror.net>, netdev <netdev@vger.kernel.org>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
 <20191108130123.6839-47-linux@rasmusvillemoes.dk>
 <CAOZdJXUX2cZfaQTkBdNrwD=jT2399rZzRFtDj6vNa==9Bmkh5A@mail.gmail.com>
 <CADRPPNS00uU+f6ap9D-pYQUFo_T-o2bgtnYaE9qAXOwck86-OQ@mail.gmail.com>
 <29b45e76-f384-fe16-0891-cc51cfecefd4@rasmusvillemoes.dk>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <e251d109-9f41-4d04-927d-70fb035622e8@kernel.org>
Date:   Fri, 15 Nov 2019 08:32:26 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <29b45e76-f384-fe16-0891-cc51cfecefd4@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/19 1:54 AM, Rasmus Villemoes wrote:
> "Also, the QE Ethernet has never been integrated on any non-PowerPC SoC
> and most likely will not be in the future."

That works for me, thanks.
