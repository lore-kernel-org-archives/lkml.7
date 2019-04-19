Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337F0C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FE8204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfDSSbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:31:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:24408 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbfDSSa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:30:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Apr 2019 03:12:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,369,1549958400"; 
   d="scan'208";a="166092375"
Received: from ckoradax-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.48.177])
  by fmsmga001.fm.intel.com with ESMTP; 19 Apr 2019 03:12:23 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] docs: hwmon: convert three docs to ReST format
In-Reply-To: <20190418151028.341723f7@coco.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <287cf72fc213656c1593f8bd42feb62f7a5f26e7.1555580417.git.mchehab+samsung@kernel.org> <87k1frgysq.fsf@intel.com> <20190418151028.341723f7@coco.lan>
Date:   Fri, 19 Apr 2019 13:12:26 +0300
Message-ID: <877ebqgv79.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2019, Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> Em Thu, 18 Apr 2019 17:42:29 +0300
> Jani Nikula <jani.nikula@linux.intel.com> escreveu:
>
>> On Thu, 18 Apr 2019, Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
>> > Those three new drivers were missed on the initial conversion
>> > to ReST format. So:
>> >
>> > - Rename them to .rst;
>> > - Add them to the hwmon index.rst index;
>> > - add some blank lines at the "Supported systems:" part, in
>> >   order to allow Sphinx to properly identify new lines,
>> >   suppressing warnings and avoid it to output some random
>> >   lines in bold;
>> > - When multiple authors are involved, change the authors
>> >   part to a list, in order to avoid adding blank lines.
>> > - adjust the table cells (one of the tables seemed to be
>> >   assuming that tab is 4 positions instead of 8) and add
>> >   the table markup.
>> > - be sure that the section markups have the same number of
>> >   characters as the section title.
>> >
>> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
>> > ---
>> >  Documentation/hwmon/index.rst                 |  3 +++
>> >  Documentation/hwmon/{ir38064 => ir38064.rst}  | 21 ++++++++++++-------
>> >  .../hwmon/{isl68137 => isl68137.rst}          | 16 ++++++++++----
>> >  .../hwmon/{lochnagar => lochnagar.rst}        |  7 +++++--
>> >  4 files changed, 33 insertions(+), 14 deletions(-)
>> >  rename Documentation/hwmon/{ir38064 => ir38064.rst} (76%)
>> >  rename Documentation/hwmon/{isl68137 => isl68137.rst} (85%)
>> >  rename Documentation/hwmon/{lochnagar => lochnagar.rst} (93%)
>> >
>> > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
>> > index 893804414510..3fa14fe7b49c 100644
>> > --- a/Documentation/hwmon/index.rst
>> > +++ b/Documentation/hwmon/index.rst
>> > @@ -65,6 +65,8 @@ Hardware Monitoring Kernel Drivers
>> >     ina2xx.rst
>> >     ina3221.rst
>> >     ir35221.rst
>> > +   ir38064.rst
>> > +   isl68137.rst  
>> 
>> Didn't notice it on the first patch adding index.rst, but I don't think
>> it's customary to add .rst suffix to the toctree.
>
> Provided that all documents are at the same time, I guess it
> doesn't matter having a .rst there or not.

Parse error. No other index.rst has the suffixes.

> Btw, newer versions of Sphinx build can work with other formats
> like markdown. I suspect that, if we end mixing markdown documents,
> it would be worth having the extension there.
>
> FYI, someone recently added a markdown file at the tree:
>
> commit e453fa60e086786fe89ba15ee8fef80bc2e6ecc3
> Author: Sascha Hauer <s.hauer@pengutronix.de>
> Date:   Fri Sep 7 14:36:46 2018 +0200
>
>     Documentation: ubifs: Add authentication whitepaper
>
> 	Documentation/filesystems/ubifs-authentication.md
>
> IMO, the best would be to just run pandoc into it and convert
> to .rst, than to mix different markup languages.

Agreed. I'd rather we keep it all rst.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
