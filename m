Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26B3C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 20:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09F32086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 20:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbfHEUoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 16:44:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:61059 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730690AbfHEUoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 16:44:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 13:44:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="373200445"
Received: from alison-desk.jf.intel.com ([10.54.74.53])
  by fmsmga005.fm.intel.com with ESMTP; 05 Aug 2019 13:44:06 -0700
Date:   Mon, 5 Aug 2019 13:44:53 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ben Boeckel <mathstuf@gmail.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-mm@kvack.org,
        kvm@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 57/59] x86/mktme: Document the MKTME Key Service API
Message-ID: <20190805204453.GB7592@alison-desk.jf.intel.com>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
 <20190731150813.26289-58-kirill.shutemov@linux.intel.com>
 <20190805115837.GB31656@rotor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805115837.GB31656@rotor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 07:58:37AM -0400, Ben Boeckel wrote:
> On Wed, Jul 31, 2019 at 18:08:11 +0300, Kirill A. Shutemov wrote:
> > +	key = add_key("mktme", "name", "no-encrypt", strlen(options_CPU),
> > +		      KEY_SPEC_THREAD_KEYRING);
> 
> Should this be `type=no-encrypt` here? Also, seems like copy/paste from
> the `type=cpu` case for the `strlen` call.
> 
> --Ben

Yes. Fixed up as follows:

	Add a "no-encrypt' type key::

        char \*options_NOENCRYPT = "type=no-encrypt";

        key = add_key("mktme", "name", options_NOENCRYPT,
                      strlen(options_NOENCRYPT), KEY_SPEC_THREAD_KEYRING);

Thanks for the review,
Alison

