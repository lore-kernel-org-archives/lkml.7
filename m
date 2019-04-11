Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCD3C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A573C2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfDKNFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:05:42 -0400
Received: from foss.arm.com ([217.140.101.70]:42558 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbfDKNFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:05:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83C3B374;
        Thu, 11 Apr 2019 06:05:41 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E94F3F557;
        Thu, 11 Apr 2019 06:05:41 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id A24BF680137; Thu, 11 Apr 2019 14:05:39 +0100 (BST)
Date:   Thu, 11 Apr 2019 14:05:39 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 02/21] docs: hwmon: vexpress: convert to ReST format
Message-ID: <20190411130539.GG15144@e110455-lin.cambridge.arm.com>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
 <2d732435f94520681fec52c12dae5d26b356c5f7.1554923967.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d732435f94520681fec52c12dae5d26b356c5f7.1554923967.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 04:22:39PM -0300, Mauro Carvalho Chehab wrote:
> Convert vexpress to ReST format, in order to allow it to
> be parsed by Sphinx.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  Documentation/hwmon/vexpress | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/hwmon/vexpress b/Documentation/hwmon/vexpress
> index 557d6d5ad90d..8c861c8151ac 100644
> --- a/Documentation/hwmon/vexpress
> +++ b/Documentation/hwmon/vexpress
> @@ -2,14 +2,21 @@ Kernel driver vexpress
>  ======================
>  
>  Supported systems:
> +
>    * ARM Ltd. Versatile Express platform
> +
>      Prefix: 'vexpress'
> +
>      Datasheets:
> +
>        * "Hardware Description" sections of the Technical Reference Manuals
> -        for the Versatile Express boards:
> -        http://infocenter.arm.com/help/topic/com.arm.doc.subset.boards.express/index.html
> +	for the Versatile Express boards:
> +
> +	- http://infocenter.arm.com/help/topic/com.arm.doc.subset.boards.express/index.html
> +
>        * Section "4.4.14. System Configuration registers" of the V2M-P1 TRM:
> -        http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0447-/index.html
> +
> +	- http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0447-/index.html
>  
>  Author: Pawel Moll
>  
> -- 
> 2.20.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
