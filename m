Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78ECC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A658F20684
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbfFLHyP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 03:54:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:56056 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfFLHyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 03:54:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 00:54:14 -0700
X-ExtLoop1: 1
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.150])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jun 2019 00:54:12 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net, kernel@collabora.com,
        =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>
Subject: Re: [PATCH] sphinx.rst: Add note about code snippets embedded in the text
In-Reply-To: <20190611200316.30054-1-andrealmeid@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190611200316.30054-1-andrealmeid@collabora.com>
Date:   Wed, 12 Jun 2019 10:57:12 +0300
Message-ID: <87ftofxmlj.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2019, André Almeida <andrealmeid@collabora.com> wrote:
> There's a paragraph that explains how to create fixed width text block,
> but it doesn't explains how to create fixed width text inline, although
> this feature is really used through the documentation. Fix that adding a
> quick note about it.

I don't mind this addition, it's simple enough, but in general I think
we should reference the Sphinx and reStructuredText documentation,
whichever is more applicable, instead of duplicating the
documentation. The idea is that this document describes how to use them
in kernel. Contrast with coding style and language reference.

BR,
Jani.


>
> Signed-off-by: André Almeida <andrealmeid@collabora.com>
> ---
>  Documentation/doc-guide/sphinx.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
> index c039224b404e..f48abc07f4c5 100644
> --- a/Documentation/doc-guide/sphinx.rst
> +++ b/Documentation/doc-guide/sphinx.rst
> @@ -218,7 +218,7 @@ Here are some specific guidelines for the kernel documentation:
>    examples, etc.), use ``::`` for anything that doesn't really benefit
>    from syntax highlighting, especially short snippets. Use
>    ``.. code-block:: <language>`` for longer code blocks that benefit
> -  from highlighting.
> +  from highlighting. For a short snippet of code embedded in the text, use \`\`.
>  
>  
>  the C domain

-- 
Jani Nikula, Intel Open Source Graphics Center
