Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46613C3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E910216C8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbfIBNqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:46:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:32119 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfIBNqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:46:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 06:46:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,459,1559545200"; 
   d="scan'208";a="211690834"
Received: from doblerbe-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.53.100])
  by fmsmga002.fm.intel.com with ESMTP; 02 Sep 2019 06:46:30 -0700
Date:   Mon, 2 Sep 2019 16:46:28 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jordan Hand <jorhand@linux.microsoft.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tpm: Parse event log from TPM2 ACPI table
Message-ID: <20190902134628.yaqvdur4utnjrj3d@linux.intel.com>
References: <20190831051027.11544-1-jorhand@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190831051027.11544-1-jorhand@linux.microsoft.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 10:10:27PM -0700, Jordan Hand wrote:
> For systems with a TPM2 chip which use ACPI to expose event logs, retrieve the
> crypto-agile event log from the TPM2 ACPI table. The TPM2 table is defined
> in section 7.3 of the TCG ACPI Specification (see link).
> 
> The TPM2 table is used by SeaBIOS in place of the TCPA table when the system's
> TPM is version 2.0 to denote (among other metadata) the location of the
> crypto-agile log.
> 
> Link: https://trustedcomputinggroup.org/resource/tcg-acpi-specification/
> Signed-off-by: Jordan Hand <jorhand@linux.microsoft.com>

Where is the changelog for v2 and v3 i.e. what happened in those
updates?

/Jarkko
