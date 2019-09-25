Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61186C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 08:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E41F222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 08:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442766AbfIYIfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 04:35:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:57339 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405299AbfIYIfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 04:35:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2019 01:35:23 -0700
X-IronPort-AV: E=Sophos;i="5.64,547,1559545200"; 
   d="scan'208";a="183186690"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2019 01:35:20 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: Use make invocation's -j argument for parallelism
In-Reply-To: <201909240910.D6E5C767D1@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <201909191438.C00E6DB@keescook> <20190922140331.3ffe8604@lwn.net> <201909231537.0FC0474C@keescook> <87pnjqtbft.fsf@intel.com> <201909240910.D6E5C767D1@keescook>
Date:   Wed, 25 Sep 2019 11:35:17 +0300
Message-ID: <87blv8u62i.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2019, Kees Cook <keescook@chromium.org> wrote:
> On Tue, Sep 24, 2019 at 10:12:22AM +0300, Jani Nikula wrote:
>> On Mon, 23 Sep 2019, Kees Cook <keescook@chromium.org> wrote:
>> > On Sun, Sep 22, 2019 at 02:03:31PM -0600, Jonathan Corbet wrote:
>> >> On Thu, 19 Sep 2019 14:44:37 -0700
>> >> Kees Cook <keescook@chromium.org> wrote:
>> >> 
>> >> > While sphinx 1.7 and later supports "-jauto" for parallelism, this
>> >> > effectively ignores the "-j" flag used in the "make" invocation, which
>> >> > may cause confusion for build systems. Instead, extract the available
>> >> 
>> >> What sort of confusion might we expect?  Or, to channel akpm, "what are the
>> >> user-visible effects of this bug"?
>> >
>> > When I run "make htmldocs -j16" with a pre-1.7 sphinx, it is not
>> > parallelized. When I run "make htmldocs -j8" with 1.7+ sphinx, it uses
>> > all my CPUs instead of 8. :)
>> 
>> To be honest, part of the solution should be to require Sphinx 1.8 or
>> later. Even Debian stable has it. If your distro doesn't have it
>> (really?), using the latest Sphinx in a virtual environment should be a
>> matter of:
>> 
>> $ python3 -m venv .venv
>> $ . .venv/bin/activate
>> (.venv) $ pip install sphinx sphinx_rtd_theme
>> (.venv) $ make htmldocs
>
> I don't mind having sphinx 1.8 (I did, in fact, already update it), but
> that still doesn't solve the whole problem: my -j argument is being
> ignored...

I meant, *part* of the solution should be to not have to deal with
ancient Sphinx.

BR,
Jani.



-- 
Jani Nikula, Intel Open Source Graphics Center
