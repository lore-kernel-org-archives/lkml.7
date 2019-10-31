Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB5FCA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D6721734
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbfJaQsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:48:21 -0400
Received: from foss.arm.com ([217.140.110.172]:51984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728614AbfJaQsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:48:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 977111FB;
        Thu, 31 Oct 2019 09:48:20 -0700 (PDT)
Received: from [10.1.196.50] (unknown [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C56383F6C4;
        Thu, 31 Oct 2019 09:48:19 -0700 (PDT)
Subject: Re: [PATCH 4/4] docs/arm64: cpu-feature-registers: Documents missing
 visible fields
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     will@kernel.org, catalin.marinas@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "julien@xen.org" <julien@xen.org>
References: <20191003111211.483-1-julien.grall@arm.com>
 <20191003111211.483-5-julien.grall@arm.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <9a4aa626-a16f-b01a-0254-43946de9ff6e@arm.com>
Date:   Thu, 31 Oct 2019 16:48:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191003111211.483-5-julien.grall@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/10/2019 12:12, Julien Grall wrote:
> A couple of fields visible to userspace are not described in the
> documentation. So update it.
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> ---
>   Documentation/arm64/cpu-feature-registers.rst | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
> index 2955287e9acc..ffcf4e2c71ef 100644
> --- a/Documentation/arm64/cpu-feature-registers.rst
> +++ b/Documentation/arm64/cpu-feature-registers.rst
> @@ -193,6 +193,10 @@ infrastructure:
>        +------------------------------+---------+---------+
>        | Name                         |  bits   | visible |
>        +------------------------------+---------+---------+
> +     | SB                           | [36-39] |    y    |
> +     +------------------------------+---------+---------+
> +     | FRINTTS                      | [32-35] |    y    |
> +     +------------------------------+---------+---------+

Will reported the bitfields were inconsistent (see [1]). Looking in more 
details, it seems that I messed up this patch when sending it (I honestly can't 
remember why I wrote like that :().

@Catalin, I saw you applied this patch to for-next/elf-hwcap-docs. Would you
mind to update the content of the patch? Or do you prefer a new version?

>        | GPI                          | [31-28] |    y    |
>        +------------------------------+---------+---------+
>        | GPA                          | [27-24] |    y    |
> 

Cheers,

[1] <20191029111517.GE11590@willie-the-truck>

-- 
Julien Grall
