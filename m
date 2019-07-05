Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91489C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B70020836
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfGEKLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 06:11:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:21512 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfGEKLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 06:11:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 03:11:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,454,1557212400"; 
   d="scan'208";a="363145148"
Received: from jsakkine-mobl1.tm.intel.com ([10.237.50.189])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jul 2019 03:11:38 -0700
Message-ID: <628829d34af3b245ea3409d20a5cb8d956d6957d.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: Document UEFI event log quirks
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     tweek@google.com, matthewgarrett@google.com,
        Jonathan Corbet <corbet@lwn.net>
Date:   Fri, 05 Jul 2019 13:11:37 +0300
In-Reply-To: <20190703161109.22935-1-jarkko.sakkinen@linux.intel.com>
References: <20190703161109.22935-1-jarkko.sakkinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +| Authors:
> +| Stefan Berger <stefanb@linux.vnet.ibm.com>

I was looking how the rst formatting went from Stefan's
document. This one is authored by me.

/Jarkko

