Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30610C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE6E20645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733244AbfETM4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:56:45 -0400
Received: from smtprelay0116.hostedemail.com ([216.40.44.116]:49686 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728898AbfETM4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:56:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id C0A8818224D8A;
        Mon, 20 May 2019 12:56:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: salt35_66507bbc90e
X-Filterd-Recvd-Size: 974
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Mon, 20 May 2019 12:56:42 +0000 (UTC)
Message-ID: <ed26df86d7d0e12263404842895460b1611def61.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add test for empty line after Fixes
 statement
From:   Joe Perches <joe@perches.com>
To:     Michal Kalderon <michal.kalderon@marvell.com>, leon@kernel.org,
        apw@canonical.com
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 20 May 2019 05:56:36 -0700
In-Reply-To: <20190520124238.10298-1-michal.kalderon@marvell.com>
References: <20190520124238.10298-1-michal.kalderon@marvell.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-20 at 15:42 +0300, Michal Kalderon wrote:
> Check that there is no empty line after a fixes statement

why?


