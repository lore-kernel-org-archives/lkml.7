Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50218C5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2715E217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbfKFMha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 07:37:30 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:56275 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbfKFMh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 07:37:29 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 302e3675ce793f7a; Wed, 6 Nov 2019 13:37:27 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Jamal Shareef <jamal.k.shareef@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        srinivas.pandruvada@linux.intel.com, lenb@kernel.org,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix sparse plain int pointer
Date:   Wed, 06 Nov 2019 13:37:27 +0100
Message-ID: <1650009.YP25ckTgOY@kreacher>
In-Reply-To: <20191105055427.11943-1-jamal.k.shareef@gmail.com>
References: <20191105055427.11943-1-jamal.k.shareef@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, November 5, 2019 6:54:27 AM CET Jamal Shareef wrote:
> Patch fixes sparse warning: Using plain integer as NULL pointer.
> Replaces assignment of 0 to pointer with NULL assignment.
> 
> Signed-off-by: Jamal Shareef <jamal.k.shareef@gmail.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 53a51c169451..cfcf34e04c3d 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2664,21 +2664,21 @@ enum {
>  
>  /* Hardware vendor-specific info that has its own power management modes */
>  static struct acpi_platform_list plat_info[] __initdata = {
> -	{"HP    ", "ProLiant", 0, ACPI_SIG_FADT, all_versions, 0, PSS},
> -	{"ORACLE", "X4-2    ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
> -	{"ORACLE", "X4-2L   ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
> -	{"ORACLE", "X4-2B   ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
> -	{"ORACLE", "X3-2    ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
> -	{"ORACLE", "X3-2L   ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
> -	{"ORACLE", "X3-2B   ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
> -	{"ORACLE", "X4470M2 ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
> -	{"ORACLE", "X4270M3 ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
> -	{"ORACLE", "X4270M2 ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
> -	{"ORACLE", "X4170M2 ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
> -	{"ORACLE", "X4170 M3", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
> -	{"ORACLE", "X4275 M3", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
> -	{"ORACLE", "X6-2    ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
> -	{"ORACLE", "Sudbury ", 0, ACPI_SIG_FADT, all_versions, 0, PPC},
> +	{"HP    ", "ProLiant", 0, ACPI_SIG_FADT, all_versions, NULL, PSS},
> +	{"ORACLE", "X4-2    ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
> +	{"ORACLE", "X4-2L   ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
> +	{"ORACLE", "X4-2B   ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
> +	{"ORACLE", "X3-2    ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
> +	{"ORACLE", "X3-2L   ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
> +	{"ORACLE", "X3-2B   ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
> +	{"ORACLE", "X4470M2 ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
> +	{"ORACLE", "X4270M3 ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
> +	{"ORACLE", "X4270M2 ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
> +	{"ORACLE", "X4170M2 ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
> +	{"ORACLE", "X4170 M3", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
> +	{"ORACLE", "X4275 M3", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
> +	{"ORACLE", "X6-2    ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
> +	{"ORACLE", "Sudbury ", 0, ACPI_SIG_FADT, all_versions, NULL, PPC},
>  	{ } /* End */
>  };
>  
> 

Applying as 5.5 material, thanks!




