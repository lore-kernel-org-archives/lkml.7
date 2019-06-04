Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F6AC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105D42081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfFDPMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 11:12:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:11667 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbfFDPMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 11:12:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 08:12:53 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 04 Jun 2019 08:12:53 -0700
Received: from kwong4-mobl.amr.corp.intel.com (unknown [10.252.203.122])
        by linux.intel.com (Postfix) with ESMTP id 43E185800BD;
        Tue,  4 Jun 2019 08:12:52 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v2 13/22] docs: soundwire: locking: fix tags
 for a code-block
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     alsa-devel@alsa-project.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <cover.1559656538.git.mchehab+samsung@kernel.org>
 <0ea9c284f8db3867985c410d2764a2b68e5b35c1.1559656538.git.mchehab+samsung@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <50782689-9cc1-9f4e-c2c0-23e6229cd2be@linux.intel.com>
Date:   Tue, 4 Jun 2019 10:12:52 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <0ea9c284f8db3867985c410d2764a2b68e5b35c1.1559656538.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/19 9:17 AM, Mauro Carvalho Chehab wrote:
> There's an ascii artwork at Example 1 whose code-block is not properly
> idented, causing those warnings.
> 
>      Documentation/driver-api/soundwire/locking.rst:50: WARNING: Inconsistent literal block quoting.
>      Documentation/driver-api/soundwire/locking.rst:51: WARNING: Line block ends without a blank line.
>      Documentation/driver-api/soundwire/locking.rst:55: WARNING: Inline substitution_reference start-string without end-string.
>      Documentation/driver-api/soundwire/locking.rst:56: WARNING: Line block ends without a blank line.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks for fixing this.

> ---
>   Documentation/driver-api/soundwire/locking.rst | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/soundwire/locking.rst b/Documentation/driver-api/soundwire/locking.rst
> index 253f73555255..3a7ffb3d87f3 100644
> --- a/Documentation/driver-api/soundwire/locking.rst
> +++ b/Documentation/driver-api/soundwire/locking.rst
> @@ -44,7 +44,9 @@ Message transfer.
>        b. Transfer message (Read/Write) to Slave1 or broadcast message on
>           Bus in case of bank switch.
>   
> -     c. Release Message lock ::
> +     c. Release Message lock
> +
> +     ::
>   
>   	+----------+                    +---------+
>   	|          |                    |         |
> 

