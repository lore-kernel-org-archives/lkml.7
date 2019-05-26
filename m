Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D91C282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 22:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95C02075C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 22:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfEZW1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 18:27:46 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:38718 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfEZW1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 18:27:46 -0400
Received: from x4db76deb.dyn.telefonica.de ([77.183.109.235] helo=[10.0.95.2])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hV1cF-0004F7-V8; Sun, 26 May 2019 23:27:44 +0100
Subject: Re: [PATCH] drm/tegra: fix warning PTR_ERR_OR_ZERO can be used
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190525070353.GA6727@hari-Inspiron-1545>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <7446cd38-71c5-284d-8a9a-b5ac6865bf35@codethink.co.uk>
Date:   Sun, 26 May 2019 23:27:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190525070353.GA6727@hari-Inspiron-1545>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2019 08:03, Hariprasad Kelam wrote:
> fix below warnings reported by coccicheck
> 
> /drivers/gpu/drm/tegra/drm.c:509:1-3: WARNING: PTR_ERR_OR_ZERO can be
> used
> ./drivers/gpu/drm/tegra/gem.c:419:1-3: WARNING: PTR_ERR_OR_ZERO can be
> used

I'd say the coccicheck should say "Improvement:" here, it's not
something wrong, just code that has a better call available.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
