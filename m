Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D48C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4419720720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgAHP6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:58:46 -0500
Received: from mga06.intel.com ([134.134.136.31]:24326 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729151AbgAHP6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:58:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 07:58:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="217546290"
Received: from dkurtaev-mobl.ccr.corp.intel.com ([10.252.22.167])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jan 2020 07:58:42 -0800
Message-ID: <b469b7e8454a69402529cc8e25244860e136308e.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: handle negative priv->response_len in
 tpm_common_read
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, linux-integrity@vger.kernel.org,
        labbott@redhat.com
Date:   Wed, 08 Jan 2020 17:58:41 +0200
In-Reply-To: <157843468820.24718.10808226634364669421.stgit@tstruk-mobl1>
References: <b85fa669-d3aa-f6c9-9631-988ae47e392c@redhat.com>
         <157843468820.24718.10808226634364669421.stgit@tstruk-mobl1>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-01-07 at 14:04 -0800, Tadeusz Struk wrote:
> The priv->responce_length can hold the size of an response or
> an negative error code, and the tpm_common_read() needs to handle
> both cases correctly. Changed the type of responce_length to
> signed and accounted for negative value in tpm_common_read()
> 
> Cc: stable@vger.kernel.org
> Fixes: d23d12484307 ("tpm: fix invalid locking in NONBLOCKING mode")
> Reported-by: Laura Abbott <labbott@redhat.com>
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Adding to the next PR.

/Jarkko

