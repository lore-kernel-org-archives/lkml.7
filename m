Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE110C0030B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 17:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7883208C3
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 17:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395200AbfIGR20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 13:28:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:43165 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729074AbfIGR20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 13:28:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2019 10:28:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,478,1559545200"; 
   d="scan'208";a="208546920"
Received: from perezfra-mobl.ger.corp.intel.com ([10.249.34.186])
  by fmsmga004.fm.intel.com with ESMTP; 07 Sep 2019 10:28:20 -0700
Message-ID: <0dfdac6faab2ebeb3bbffd1ce66b26f26dab03f5.camel@linux.intel.com>
Subject: Re: [PATCH v5] tpm: Parse event log from TPM2 ACPI table
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jordan Hand <jorhand@linux.microsoft.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 07 Sep 2019 20:28:13 +0300
In-Reply-To: <20190903185239.30643-1-jorhand@linux.microsoft.com>
References: <20190903185239.30643-1-jorhand@linux.microsoft.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-03 at 11:52 -0700, Jordan Hand wrote:
> For systems with a TPM2 chip which use ACPI to expose event logs,
> retrieve the crypto-agile event log from the TPM2 ACPI table. The TPM2
> table is defined in section 7.3 of the TCG ACPI Specification (see link).
> 
> The TPM2 table is used by SeaBIOS in place of the TCPA table when the
> system's TPM is version 2.0 to denote (among other metadata) the location
> of the crypto-agile log.
> 
> Link: https://trustedcomputinggroup.org/resource/tcg-acpi-specification/
> Signed-off-by: Jordan Hand <jorhand@linux.microsoft.com>

You should rather rename the existing function as
tpm_read_log_acpi_tcpa() and create a new one with the name
tpm_read_log_acpi_tpm2().

/Jarkko

