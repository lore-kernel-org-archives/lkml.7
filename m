Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A642C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53672238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfGYNHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:07:09 -0400
Received: from mga07.intel.com ([134.134.136.100]:36350 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbfGYNHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:07:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 06:07:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,306,1559545200"; 
   d="scan'208";a="345430331"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 25 Jul 2019 06:07:07 -0700
Received: from xiliu-mobl1.amr.corp.intel.com (unknown [10.252.200.163])
        by linux.intel.com (Postfix) with ESMTP id EBD98580107;
        Thu, 25 Jul 2019 06:07:06 -0700 (PDT)
Subject: Re: [PATCH] ASoC: Intel: Fix some acpi vs apci typo in somme comments
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190725053523.16542-1-christophe.jaillet@wanadoo.fr>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <bf0899e7-42ff-b2e9-6f51-decc0b0de3ff@linux.intel.com>
Date:   Thu, 25 Jul 2019 08:07:14 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725053523.16542-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/19 12:35 AM, Christophe JAILLET wrote:
> Fix some typo to have the filaname given in a comment match the real name
> of the file.
> Some 'acpi' have erroneously been written 'apci'
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

yes, thanks for the corrections.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/intel/common/soc-acpi-intel-bxt-match.c     | 2 +-
>   sound/soc/intel/common/soc-acpi-intel-byt-match.c     | 2 +-
>   sound/soc/intel/common/soc-acpi-intel-cht-match.c     | 2 +-
>   sound/soc/intel/common/soc-acpi-intel-cnl-match.c     | 2 +-
>   sound/soc/intel/common/soc-acpi-intel-glk-match.c     | 2 +-
>   sound/soc/intel/common/soc-acpi-intel-hda-match.c     | 2 +-
>   sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c | 2 +-
>   sound/soc/intel/common/soc-acpi-intel-icl-match.c     | 2 +-
>   sound/soc/intel/common/soc-acpi-intel-kbl-match.c     | 2 +-
>   sound/soc/intel/common/soc-acpi-intel-skl-match.c     | 2 +-
>   10 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
> index 229e39586868..4a5adae1d785 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * soc-apci-intel-bxt-match.c - tables and support for BXT ACPI enumeration.
> + * soc-acpi-intel-bxt-match.c - tables and support for BXT ACPI enumeration.
>    *
>    * Copyright (c) 2018, Intel Corporation.
>    *
> diff --git a/sound/soc/intel/common/soc-acpi-intel-byt-match.c b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
> index b94b482ac34f..1cc801ba92eb 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-byt-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
> - * soc-apci-intel-byt-match.c - tables and support for BYT ACPI enumeration.
> + * soc-acpi-intel-byt-match.c - tables and support for BYT ACPI enumeration.
>    *
>    * Copyright (c) 2017, Intel Corporation.
>    */
> diff --git a/sound/soc/intel/common/soc-acpi-intel-cht-match.c b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
> index b7f11f6be1cf..d0fb43c2b9f6 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-cht-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
> - * soc-apci-intel-cht-match.c - tables and support for CHT ACPI enumeration.
> + * soc-acpi-intel-cht-match.c - tables and support for CHT ACPI enumeration.
>    *
>    * Copyright (c) 2017, Intel Corporation.
>    */
> diff --git a/sound/soc/intel/common/soc-acpi-intel-cnl-match.c b/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
> index c36c0aa4f683..771b0ef21051 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * soc-apci-intel-cnl-match.c - tables and support for CNL ACPI enumeration.
> + * soc-acpi-intel-cnl-match.c - tables and support for CNL ACPI enumeration.
>    *
>    * Copyright (c) 2018, Intel Corporation.
>    *
> diff --git a/sound/soc/intel/common/soc-acpi-intel-glk-match.c b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
> index 616eb09e78a0..60dea358fa04 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-glk-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * soc-apci-intel-glk-match.c - tables and support for GLK ACPI enumeration.
> + * soc-acpi-intel-glk-match.c - tables and support for GLK ACPI enumeration.
>    *
>    * Copyright (c) 2018, Intel Corporation.
>    *
> diff --git a/sound/soc/intel/common/soc-acpi-intel-hda-match.c b/sound/soc/intel/common/soc-acpi-intel-hda-match.c
> index 68ae43f7b4b2..cc972d2ac691 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-hda-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-hda-match.c
> @@ -2,7 +2,7 @@
>   // Copyright (c) 2018, Intel Corporation.
>   
>   /*
> - * soc-apci-intel-hda-match.c - tables and support for HDA+ACPI enumeration.
> + * soc-acpi-intel-hda-match.c - tables and support for HDA+ACPI enumeration.
>    *
>    */
>   
> diff --git a/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c b/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
> index d27853e7a369..34eb0baaa951 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
> - * soc-apci-intel-hsw-bdw-match.c - tables and support for ACPI enumeration.
> + * soc-acpi-intel-hsw-bdw-match.c - tables and support for ACPI enumeration.
>    *
>    * Copyright (c) 2017, Intel Corporation.
>    */
> diff --git a/sound/soc/intel/common/soc-acpi-intel-icl-match.c b/sound/soc/intel/common/soc-acpi-intel-icl-match.c
> index 0b430b9b3673..38977669b576 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-icl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-icl-match.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * soc-apci-intel-icl-match.c - tables and support for ICL ACPI enumeration.
> + * soc-acpi-intel-icl-match.c - tables and support for ICL ACPI enumeration.
>    *
>    * Copyright (c) 2018, Intel Corporation.
>    *
> diff --git a/sound/soc/intel/common/soc-acpi-intel-kbl-match.c b/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
> index 4b331058e807..e200baa11011 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * soc-apci-intel-kbl-match.c - tables and support for KBL ACPI enumeration.
> + * soc-acpi-intel-kbl-match.c - tables and support for KBL ACPI enumeration.
>    *
>    * Copyright (c) 2018, Intel Corporation.
>    *
> diff --git a/sound/soc/intel/common/soc-acpi-intel-skl-match.c b/sound/soc/intel/common/soc-acpi-intel-skl-match.c
> index 0c9c0edd35b3..42fa40a8d932 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-skl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-skl-match.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * soc-apci-intel-skl-match.c - tables and support for SKL ACPI enumeration.
> + * soc-acpi-intel-skl-match.c - tables and support for SKL ACPI enumeration.
>    *
>    * Copyright (c) 2018, Intel Corporation.
>    *
> 

