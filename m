Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E93C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CCF208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgAGU1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:27:38 -0500
Received: from mga01.intel.com ([192.55.52.88]:5305 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728451AbgAGU1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:27:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 12:27:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,407,1571727600"; 
   d="scan'208";a="222717999"
Received: from tstruk-mobl1.jf.intel.com (HELO [10.7.196.67]) ([10.7.196.67])
  by orsmga006.jf.intel.com with ESMTP; 07 Jan 2020 12:27:37 -0800
Subject: Re: Bad usercopy from tpm after d23d12484307 ("tpm: fix invalid
 locking in NONBLOCKING mode")
To:     Laura Abbott <labbott@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <b85fa669-d3aa-f6c9-9631-988ae47e392c@redhat.com>
From:   Tadeusz Struk <tadeusz.struk@intel.com>
Autocrypt: addr=tadeusz.struk@intel.com; keydata=
 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
Message-ID: <d8873e8d-358c-18f7-69b8-9c2467eafc4c@intel.com>
Date:   Tue, 7 Jan 2020 12:27:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b85fa669-d3aa-f6c9-9631-988ae47e392c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/20 10:51 AM, Laura Abbott wrote:
> I think this is related to d23d12484307 ("tpm: fix invalid locking in
> NONBLOCKING mode")
> Specifically, if tpm_try_get_ops fails I don't think we should be
> putting the error
> code in priv->response_length since tpm_common_read doesn't seem to
> account for
> negative errno values.
> 
> I don't have a reproducer since this was just what was reported to
> Fedora's bug
> reporter but both reports happened after that commit landed in stable.

Thank you for the report Laura. Fix is on the way.

-- 
Tadeusz
