Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73205C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55647205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732164AbfFXQbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 12:31:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:24104 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728544AbfFXQbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:31:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 09:31:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,412,1557212400"; 
   d="scan'208";a="169493454"
Received: from akolosov-mobl1.ger.corp.intel.com ([10.249.33.80])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jun 2019 09:31:02 -0700
Message-ID: <9f89b976d0fc85fc07d1c5cd1d201c389ba7875b.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: Get TCG log from TPM2 ACPI table for tpm2 systems
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jordan Hand <jordanhand22@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 24 Jun 2019 19:31:01 +0300
In-Reply-To: <20190624034734.15957-1-jordanhand22@gmail.com>
References: <20190624034734.15957-1-jordanhand22@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-06-23 at 20:47 -0700, Jordan Hand wrote:
> For TPM2-based systems, retrieve the TCG log from the TPM2 ACPI table.
> 
> Signed-off-by: Jordan Hand <jordanhand22@gmail.com>

Please write a proper long description that describes where such thing
is defined and used if you feel like refining this and sending v2.

/Jarkko

