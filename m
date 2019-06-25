Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BB8C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00FA0208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfFYNWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:22:32 -0400
Received: from smtprelay0194.hostedemail.com ([216.40.44.194]:45882 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726707AbfFYNWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:22:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 11F8D100E86CB;
        Tue, 25 Jun 2019 13:22:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wood78_8a0682b7adc37
X-Filterd-Recvd-Size: 1694
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Jun 2019 13:22:28 +0000 (UTC)
Message-ID: <56190c099e31dd0c9f56296186fdb6296afbe630.camel@perches.com>
Subject: Re: [PATCH 1/1] staging: media: fix style problem
From:   Joe Perches <joe@perches.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Aliasgar Surti <aliasgar.surti500@gmail.com>,
        mchehab@kernel.org, gregkh@linuxfoundation.org,
        sakari.ailus@linux.intel.com, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Tue, 25 Jun 2019 06:22:26 -0700
In-Reply-To: <6536b57d-fea2-e16d-2092-e9e27c51c0f1@xs4all.nl>
References: <1561099192-19638-1-git-send-email-aliasgar.surti500@gmail.com>
         <6536b57d-fea2-e16d-2092-e9e27c51c0f1@xs4all.nl>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-25 at 09:17 +0200, Hans Verkuil wrote:
> On 6/21/19 8:39 AM, Aliasgar Surti wrote:
> > From: Aliasgar Surti <aliasgar.surti500@gmail.com>
> > 
> > checkpatch reported "WARNING: line over 80 characters".
> > This patch fixes the warning for file soc_camera/soc_ov5642.c
> 
> FYI: we're not accepting patches for staging/media/soc_camera: these
> are obsolete and broken drivers.

Then mark the MAINTAINERS entry as Orphan / Obsolete

It's currently:

SOC-CAMERA V4L2 SUBSYSTEM
L:	linux-media@vger.kernel.org
T:	git git://linuxtv.org/media_tree.git
S:	Orphan
F:	include/media/soc_camera.h
F:	drivers/staging/media/soc_camera/


