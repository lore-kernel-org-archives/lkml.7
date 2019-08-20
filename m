Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B62C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E7D22DA9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbfHTNsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:48:04 -0400
Received: from smtprelay0160.hostedemail.com ([216.40.44.160]:56284 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730760AbfHTNr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:47:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 0C2DA1800F5A4;
        Tue, 20 Aug 2019 13:47:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wind43_7f520299af340
X-Filterd-Recvd-Size: 1500
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Tue, 20 Aug 2019 13:47:54 +0000 (UTC)
Message-ID: <f155ad1a9490bd273fa9c31a9745e328b346920a.camel@perches.com>
Subject: Re: [PATCH AUTOSEL 4.19 07/27] intel_th: Use the correct style for
 SPDX License Identifier
From:   Joe Perches <joe@perches.com>
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Tue, 20 Aug 2019 06:47:53 -0700
In-Reply-To: <20190820134213.11279-7-sashal@kernel.org>
References: <20190820134213.11279-1-sashal@kernel.org>
         <20190820134213.11279-7-sashal@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-20 at 09:41 -0400, Sasha Levin wrote:
> From: Nishad Kamdar <nishadkamdar@gmail.com>
> 
> [ Upstream commit fac7b714c514fcc555541e1d6450c694b0a5f8d3 ]
> 
> This patch corrects the SPDX License Identifier style
> in header files related to Drivers for Intel(R) Trace Hub
> controller.
> For C header files Documentation/process/license-rules.rst
> mandates C-like comments (opposed to C source files where
> C++ style should be used)

Is there a reason to backport license header changes?

I believe there is not.

