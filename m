Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0223C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6782063F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfCKRa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:30:59 -0400
Received: from smtprelay0235.hostedemail.com ([216.40.44.235]:45372 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726675AbfCKRa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:30:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 5B6378368EEF;
        Mon, 11 Mar 2019 17:30:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: beam84_424d195f75d32
X-Filterd-Recvd-Size: 1895
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Mon, 11 Mar 2019 17:30:55 +0000 (UTC)
Message-ID: <09ee942fb7be08c600c989217ad3abfe4b6702fd.camel@perches.com>
Subject: Re: [PATCH 4/4] leds: lm3532: Introduce the lm3532 LED driver
From:   Joe Perches <joe@perches.com>
To:     Dan Murphy <dmurphy@ti.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        robh+dt@kernel.org, pavel@ucw.cz, tony@atomide.com,
        lee.jones@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Date:   Mon, 11 Mar 2019 10:30:54 -0700
In-Reply-To: <ee13f836-bd77-22b0-e230-2fc9050afe88@ti.com>
References: <20190307220947.20057-1-dmurphy@ti.com>
         <20190307220947.20057-4-dmurphy@ti.com>
         <8ac4d84f-c792-893d-fbae-fac88fac8631@gmail.com>
         <bb621d08-c192-0018-f67e-3f3262a71b6f@ti.com>
         <cf26b351-f2b5-8345-29b7-401153b5f0d7@gmail.com>
         <ee13f836-bd77-22b0-e230-2fc9050afe88@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-11 at 12:24 -0500, Dan Murphy wrote:
> checkpatch takes issue with // in headers.
> Unless they have removed that requirement.

Awhile ago...

commit dadf680de3c2eb4cba9840619991eda0cfe98778
Author: Joe Perches <joe@perches.com>
Date:   Tue Aug 2 14:04:33 2016 -0700

    checkpatch: allow c99 style // comments
    
    Sanitise the lines that contain c99 comments so that the error doesn't
    get emitted.
    
    Link: http://lkml.kernel.org/r/d4d22c34ad7bcc1bceb52f0742f76b7a6d585235.1468368420.git.joe@perches.com
    Signed-off-by: Joe Perches <joe@perches.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

