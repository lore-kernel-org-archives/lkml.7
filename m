Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046A8C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 17:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8EB206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 17:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387725AbfHARnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 13:43:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:60777 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729881AbfHARnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 13:43:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 10:43:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,335,1559545200"; 
   d="scan'208";a="372686591"
Received: from nippert-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.36.219])
  by fmsmga006.fm.intel.com with ESMTP; 01 Aug 2019 10:43:11 -0700
Date:   Thu, 1 Aug 2019 20:43:10 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, tweek@google.com,
        matthewgarrett@google.com, jorhand@linux.microsoft.com,
        rdunlap@infradead.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v4] tpm: Document UEFI event log quirks
Message-ID: <20190801174310.n3iuqhnaulgqexfg@linux.intel.com>
References: <20190712154439.10642-1-jarkko.sakkinen@linux.intel.com>
 <20190731133948.1a527db8@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731133948.1a527db8@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 01:39:48PM -0600, Jonathan Corbet wrote:
> On Fri, 12 Jul 2019 18:44:32 +0300
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> 
> > There are some weird quirks when it comes to UEFI event log. Provide a
> > brief introduction to TPM event log mechanism and describe the quirks
> > and how they can be sorted out.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> > v4: - Unfortanely -> Unfortunately
> > v3: - Add a section for refs and use a bullet list to enumerate them.
> >     - Remove an invalid author info.
> > v2: - Fix one typo.
> >     - Refine the last paragraph to better explain how the two halves
> >       of the event log are concatenated.
> >  Documentation/security/tpm/index.rst         |  1 +
> >  Documentation/security/tpm/tpm_event_log.rst | 55 ++++++++++++++++++++
> >  2 files changed, 56 insertions(+)
> >  create mode 100644 Documentation/security/tpm/tpm_event_log.rst
> 
> I've applied this, thanks.  Before I could do so, though, I had to edit
> the headers, which read:
> 
> > Content-Type: text/plain; charset=y
> 
> "git am" *really* doesn't like "charset=y".  I think this is something
> that git send-email likes to do occasionally, don't know why...

Thank you!

/Jarkko
