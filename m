Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF15C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77EE220856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfCZKZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:25:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34012 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfCZKZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:25:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47CFE1596;
        Tue, 26 Mar 2019 03:25:46 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 178853F614;
        Tue, 26 Mar 2019 03:25:46 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 6E55A6822A4; Tue, 26 Mar 2019 10:25:44 +0000 (GMT)
Date:   Tue, 26 Mar 2019 10:25:44 +0000
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, James Wang <james.qian.wang@arm.com>,
        Mali DP Maintainers <malidp@foss.arm.com>
Subject: Re: Bad file pattern in MAINTAINERS section 'ARM KOMEDA DRM-KMS
 DRIVER'
Message-ID: <20190326102544.GB21747@e110455-lin.cambridge.arm.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190325233040.30983-1-joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190325233040.30983-1-joe@perches.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Mon, Mar 25, 2019 at 04:30:40PM -0700, Joe Perches wrote:
> A file pattern line in this section of the MAINTAINERS file in linux-next
> does not have a match in the linux source files.
> 
> This could occur because a matching filename was never added, was deleted
> or renamed in some other commit.
> 
> The commits that added and if found renamed or removed the file pattern
> are shown below.
> 
> Please fix this defect appropriately.
> 
> 1: ---------------------------------------------------------------------------
> 
> linux-next MAINTAINERS section:
> 
> 	1162	ARM KOMEDA DRM-KMS DRIVER
> 	1163	M:	James (Qian) Wang <james.qian.wang@arm.com>
> 	1164	M:	Liviu Dudau <liviu.dudau@arm.com>
> 	1165	L:	Mali DP Maintainers <malidp@foss.arm.com>
> 	1166	S:	Supported
> 	1167	T:	git git://linux-arm.org/linux-ld.git for-upstream/mali-dp
> 	1168	F:	drivers/gpu/drm/arm/display/include/
> 	1169	F:	drivers/gpu/drm/arm/display/komeda/
> -->	1170	F:	Documentation/devicetree/bindings/display/arm/arm,komeda.txt
> 	1171	F:	Documentation/gpu/komeda-kms.rst
> 
> 2: ---------------------------------------------------------------------------
> 
> The most recent commit that added or modified file pattern 'Documentation/devicetree/bindings/display/arm/arm,komeda.txt':
> 

Thanks for the report, I will send a patch to fix it.

Best regards,
Liviu

> commit ab6911b73493fac9cdcc3b2c77ddca6b1016e057
> Author: james qian wang (Arm Technology China) <james.qian.wang@arm.com>
> Date:   Thu Jan 3 11:42:05 2019 +0000
> 
>     MAINTAINERS: Add maintainer for Arm komeda driver
>     
>     v4: Added git tree [Daniel Vetter]
>     v2: Adjusted the position of KOMEDA by alphabetical order
>     
>     Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.com>
>     Acked-by: Liviu Dudau <liviu.dudau@arm.com>
>     [Updated entry to show that Mali Developers is a mailing list and
>      to add myself as maintainer]
>     Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
> 
>  MAINTAINERS | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> 3: ---------------------------------------------------------------------------
> 
> No commit with file pattern 'Documentation/devicetree/bindings/display/arm/arm,komeda.txt' was found

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
