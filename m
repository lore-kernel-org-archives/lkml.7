Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE72C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA9121707
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfGHP1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:27:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:2353 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389130AbfGHP1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:27:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2019 08:27:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,466,1557212400"; 
   d="scan'208";a="363835568"
Received: from jsakkine-mobl1.tm.intel.com ([10.237.50.189])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jul 2019 08:27:42 -0700
Message-ID: <47219a790c2c5b5a3ec0a331ece8956f9a82f45b.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: Document UEFI event log quirks
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jordan Hand <jorhand@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     tweek@google.com, matthewgarrett@google.com,
        Jonathan Corbet <corbet@lwn.net>
Date:   Mon, 08 Jul 2019 18:27:45 +0300
In-Reply-To: <33ff21e2-1e27-cc85-0ea3-5127cb2598ba@linux.microsoft.com>
References: <20190703161109.22935-1-jarkko.sakkinen@linux.intel.com>
         <dacf145d-49e0-16e5-5963-415bab1884e1@linux.microsoft.com>
         <fcf497b7aa95cd6915986bc4581f10814c4d5341.camel@linux.intel.com>
         <33ff21e2-1e27-cc85-0ea3-5127cb2598ba@linux.microsoft.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-07-07 at 21:10 -0700, Jordan Hand wrote:
> > "Thus, it nees to save the final events table size at the time to the
> > custom configuration table so that the TPM driver can later on skip the
> > events generated during the preboot time."
> > 
> Yes, that sounds more clear to me.
> 
> Thanks,
> Jordan

Awesome, thank you.

/Jarkko

