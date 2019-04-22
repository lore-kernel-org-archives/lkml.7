Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BB1C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B11720896
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="aYWWVUmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfDVQ0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:26:12 -0400
Received: from smtpcmd11116.aruba.it ([62.149.156.116]:34022 "EHLO
        smtpcmd11116.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfDVQ0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 12:26:11 -0400
Received: from [192.168.1.41] ([93.146.66.165])
        by smtpcmd11.ad.aruba.it with bizsmtp
        id 3UK92000N3Zw7e501UK9sx; Mon, 22 Apr 2019 18:19:10 +0200
Subject: Re: [PATCH v2 27/79] docs: pps.txt: convert to ReST and rename to
 pps.rst
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
 <d6ffab20421f56b72a596cc99197667ea6da99ff.1555938376.git.mchehab+samsung@kernel.org>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <d48b0aa4-2a22-933e-6e32-93405c5c7292@enneenne.com>
Date:   Mon, 22 Apr 2019 18:19:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d6ffab20421f56b72a596cc99197667ea6da99ff.1555938376.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1555949950; bh=EK4nSe1YJWsvw1duFBAabXZBUkvpQ+dEm7Zr/3gBFS8=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=aYWWVUmThbT2LO5VqbwP+wy9HSTMvsupcaugs5oWLo18FcA16bTeGnjSNusK0tU0N
         zizUE4QCFUCQARiU/cgwr/sxK77dpk/+jx/1AOKTuRVd/lL+Z3lOldoLodk0J8G7Bk
         lik4QmGWxFR/Ek70935fHl4zfaVbFVPkmr9kWpWtcgqtVHZ2joeYa7S8YklqKBu/XL
         mzsId+RHfb0taEw6V9i1kpt0NwBM5wJGtwlcF/QiwRDHYc2l5tIWm66orXS1xIYHmz
         xyQgl9N50aA1VlV6t28Cc0V5OorosXc/4zi+gBeqbKTGLeCHiXajq9TXcHlZyXvm8l
         yaQ+HK5Sq44aQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2019 15:27, Mauro Carvalho Chehab wrote:
> This file is already in a good shape: just its title and
> adding some literal block markups is needed for it to be
> part of the document.
> 
> While it has a small chapter with sysfs stuff, most of
> the document is focused on driver development.
> 
> As it describes a kernel API, move it to the driver-api
> directory.
> 
> In order to avoid conflicts, let's add an :orphan: tag
> to it, to be removed when added to the driver-api book.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
