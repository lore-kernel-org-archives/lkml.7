Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA078C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B285206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389343AbfDROmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:42:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:20392 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388392AbfDROmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:42:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Apr 2019 07:42:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,366,1549958400"; 
   d="scan'208";a="165850855"
Received: from swidman-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.47.214])
  by fmsmga001.fm.intel.com with ESMTP; 18 Apr 2019 07:42:28 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] docs: hwmon: convert three docs to ReST format
In-Reply-To: <287cf72fc213656c1593f8bd42feb62f7a5f26e7.1555580417.git.mchehab+samsung@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <287cf72fc213656c1593f8bd42feb62f7a5f26e7.1555580417.git.mchehab+samsung@kernel.org>
Date:   Thu, 18 Apr 2019 17:42:29 +0300
Message-ID: <87k1frgysq.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2019, Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> Those three new drivers were missed on the initial conversion
> to ReST format. So:
>
> - Rename them to .rst;
> - Add them to the hwmon index.rst index;
> - add some blank lines at the "Supported systems:" part, in
>   order to allow Sphinx to properly identify new lines,
>   suppressing warnings and avoid it to output some random
>   lines in bold;
> - When multiple authors are involved, change the authors
>   part to a list, in order to avoid adding blank lines.
> - adjust the table cells (one of the tables seemed to be
>   assuming that tab is 4 positions instead of 8) and add
>   the table markup.
> - be sure that the section markups have the same number of
>   characters as the section title.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/hwmon/index.rst                 |  3 +++
>  Documentation/hwmon/{ir38064 => ir38064.rst}  | 21 ++++++++++++-------
>  .../hwmon/{isl68137 => isl68137.rst}          | 16 ++++++++++----
>  .../hwmon/{lochnagar => lochnagar.rst}        |  7 +++++--
>  4 files changed, 33 insertions(+), 14 deletions(-)
>  rename Documentation/hwmon/{ir38064 => ir38064.rst} (76%)
>  rename Documentation/hwmon/{isl68137 => isl68137.rst} (85%)
>  rename Documentation/hwmon/{lochnagar => lochnagar.rst} (93%)
>
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 893804414510..3fa14fe7b49c 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -65,6 +65,8 @@ Hardware Monitoring Kernel Drivers
>     ina2xx.rst
>     ina3221.rst
>     ir35221.rst
> +   ir38064.rst
> +   isl68137.rst

Didn't notice it on the first patch adding index.rst, but I don't think
it's customary to add .rst suffix to the toctree.

BR,
Jani.

>     it87.rst
>     jc42.rst
>     k10temp.rst
> @@ -86,6 +88,7 @@ Hardware Monitoring Kernel Drivers
>     lm93.rst
>     lm95234.rst
>     lm95245.rst
> +   lochnagar.rst
>     ltc2945.rst
>     ltc2978.rst
>     ltc2990.rst
> diff --git a/Documentation/hwmon/ir38064 b/Documentation/hwmon/ir38064.rst
> similarity index 76%
> rename from Documentation/hwmon/ir38064
> rename to Documentation/hwmon/ir38064.rst
> index 9f218c39bfe6..c455d755a267 100644
> --- a/Documentation/hwmon/ir38064
> +++ b/Documentation/hwmon/ir38064.rst
> @@ -2,15 +2,18 @@ Kernel driver ir38064
>  =====================
>  
>  Supported chips:
> +
>    * Infineon IR38064
> +
>      Prefix: 'ir38064'
>      Addresses scanned: -
> +
>      Datasheet: Publicly available at the Infineon webiste
>        https://www.infineon.com/dgdl/Infineon-IR38064MTRPBF-DS-v03_07-EN.pdf?fileId=5546d462584d1d4a0158db0d9efb67ca
>  
>  Authors:
> -        Maxim Sloyko <maxims@google.com>
> -        Patrick Venture <venture@google.com>
> +      - Maxim Sloyko <maxims@google.com>
> +      - Patrick Venture <venture@google.com>
>  
>  Description
>  -----------
> @@ -26,29 +29,30 @@ devices explicitly.
>  Sysfs attributes
>  ----------------
>  
> +======================= ===========================
>  curr1_label		"iout1"
>  curr1_input		Measured output current
>  curr1_crit		Critical maximum current
>  curr1_crit_alarm	Current critical high alarm
>  curr1_max		Maximum current
> -curr1_max_alarm	Current high alarm
> +curr1_max_alarm		Current high alarm
>  
>  in1_label		"vin"
>  in1_input		Measured input voltage
>  in1_crit		Critical maximum input voltage
>  in1_crit_alarm		Input voltage critical high alarm
> -in1_min		Minimum input voltage
> +in1_min			Minimum input voltage
>  in1_min_alarm		Input voltage low alarm
>  
>  in2_label		"vout1"
>  in2_input		Measured output voltage
>  in2_lcrit		Critical minimum output voltage
> -in2_lcrit_alarm	Output voltage critical low alarm
> +in2_lcrit_alarm		Output voltage critical low alarm
>  in2_crit		Critical maximum output voltage
>  in2_crit_alarm		Output voltage critical high alarm
> -in2_max		Maximum output voltage
> +in2_max			Maximum output voltage
>  in2_max_alarm		Output voltage high alarm
> -in2_min		Minimum output voltage
> +in2_min			Minimum output voltage
>  in2_min_alarm		Output voltage low alarm
>  
>  power1_label		"pout1"
> @@ -58,4 +62,5 @@ temp1_input		Measured temperature
>  temp1_crit		Critical high temperature
>  temp1_crit_alarm	Chip temperature critical high alarm
>  temp1_max		Maximum temperature
> -temp1_max_alarm	Chip temperature high alarm
> +temp1_max_alarm		Chip temperature high alarm
> +======================= ===========================
> diff --git a/Documentation/hwmon/isl68137 b/Documentation/hwmon/isl68137.rst
> similarity index 85%
> rename from Documentation/hwmon/isl68137
> rename to Documentation/hwmon/isl68137.rst
> index 92e5c5fc5b77..a5a7c8545c9e 100644
> --- a/Documentation/hwmon/isl68137
> +++ b/Documentation/hwmon/isl68137.rst
> @@ -2,16 +2,22 @@ Kernel driver isl68137
>  ======================
>  
>  Supported chips:
> +
>    * Intersil ISL68137
> +
>      Prefix: 'isl68137'
> +
>      Addresses scanned: -
> -    Datasheet: Publicly available at the Intersil website
> +
> +    Datasheet:
> +
> +      Publicly available at the Intersil website
>        https://www.intersil.com/content/dam/Intersil/documents/isl6/isl68137.pdf
>  
>  Authors:
> -        Maxim Sloyko <maxims@google.com>
> -        Robert Lippert <rlippert@google.com>
> -        Patrick Venture <venture@google.com>
> +      - Maxim Sloyko <maxims@google.com>
> +      - Robert Lippert <rlippert@google.com>
> +      - Patrick Venture <venture@google.com>
>  
>  Description
>  -----------
> @@ -32,6 +38,7 @@ Beyond the normal sysfs pmbus attributes, the driver exposes a control attribute
>  Additional Sysfs attributes
>  ---------------------------
>  
> +======================= ====================================
>  avs(0|1)_enable		Controls the AVS state of each rail.
>  
>  curr1_label		"iin"
> @@ -70,3 +77,4 @@ temp[1-3]_crit		Critical high temperature
>  temp[1-3]_crit_alarm	Chip temperature critical high alarm
>  temp[1-3]_max		Maximum temperature
>  temp[1-3]_max_alarm	Chip temperature high alarm
> +======================= ====================================
> diff --git a/Documentation/hwmon/lochnagar b/Documentation/hwmon/lochnagar.rst
> similarity index 93%
> rename from Documentation/hwmon/lochnagar
> rename to Documentation/hwmon/lochnagar.rst
> index e9686fb3eb40..1d609c4d18c3 100644
> --- a/Documentation/hwmon/lochnagar
> +++ b/Documentation/hwmon/lochnagar.rst
> @@ -1,5 +1,5 @@
>  Kernel Driver Lochnagar
> -========================
> +=======================
>  
>  Supported systems:
>    * Cirrus Logic : Lochnagar 2
> @@ -21,6 +21,7 @@ by software.
>  Sysfs attributes
>  ----------------
>  
> +======================= =======================================================
>  temp1_input             The Lochnagar board temperature (milliCelsius)
>  in0_input               Measured voltage for DBVDD1 (milliVolts)
>  in0_label               "DBVDD1"
> @@ -76,5 +77,7 @@ curr8_label             "MICVDD"
>  power8_average          Measured average power for MICVDD (microWatts)
>  power8_average_interval Power averaging time input valid from 1 to 1708mS
>  power8_label            "MICVDD"
> +======================= =======================================================
>  
> -Note: It is not possible to measure voltage on the SYSVDD rail.
> +Note:
> +    It is not possible to measure voltage on the SYSVDD rail.

-- 
Jani Nikula, Intel Open Source Graphics Center
