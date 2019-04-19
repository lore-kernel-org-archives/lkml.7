Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD7DC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5258820821
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbfDSTGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:06:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:41024 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729087AbfDSTDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:03:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A9357AD43;
        Fri, 19 Apr 2019 10:47:48 +0000 (UTC)
Message-ID: <1555670867.6277.10.camel@suse.de>
Subject: Re: [PATCH 2/2] docs: hwmon: remove the extension from .rst files
From:   Jean Delvare <jdelvare@suse.de>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Date:   Fri, 19 Apr 2019 12:47:47 +0200
In-Reply-To: <79280b1c2193d9de3ad45df4f024a64c2c1c85d7.1555669842.git.mchehab+samsung@kernel.org>
References: <70d1286cf7ddb5c44abb7278faac4b7f135d8462.1555669842.git.mchehab+samsung@kernel.org>
         <79280b1c2193d9de3ad45df4f024a64c2c1c85d7.1555669842.git.mchehab+samsung@kernel.org>
Organization: Suse Linux
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-04-19 at 07:30 -0300, Mauro Carvalho Chehab wrote:
> On almost all places, we're including ReST files without the
> extension.
> 
> Let's remove the extension here	as well, in order to use just
> one standard.
> 

Tab in the middle of a sentence.

> Suggested-by: Jani Nikula <jani.nikula@linux.intel.
> 

The line above appears to be truncated.

> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/hwmon/index.rst | 316 +++++++++++++++++-----------------
>  1 file changed, 158 insertions(+), 158 deletions(-)

-- 
Jean Delvare
SUSE L3 Support
