Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B740C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 04:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6BD920869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 04:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfDLEFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 00:05:51 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:36103 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfDLEFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 00:05:51 -0400
Received: from localhost (50-39-168-148.bvtn.or.frontiernet.net [50.39.168.148])
        (Authenticated sender: josh@joshtriplett.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id F1BDD240004;
        Fri, 12 Apr 2019 04:05:48 +0000 (UTC)
Date:   Thu, 11 Apr 2019 21:05:46 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Sinan Kaya <Okaya@kernel.org>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org
Subject: Re: [PATCH v4 0/5] init: Do not select DEBUG_KERNEL by default
Message-ID: <20190412040546.GC1577@localhost>
References: <20190412014355.25307-1-okaya@kernel.org>
 <20190412030237.GB1577@localhost>
 <cb6b69d5-73dd-e11f-bb4c-f0ce4b9d14f0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb6b69d5-73dd-e11f-bb4c-f0ce4b9d14f0@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 11:13:42PM -0400, Sinan Kaya wrote:
> On 4/11/2019 11:02 PM, Josh Triplett wrote:
> > I noticed one minor typo in patch 1/5, with that fixed, for the whole
> > series:
> 
> Can you point to the typo?

I did, in my response to the patch itself:
s/Miscellaneous/miscellaneous/ in the new option's description, since it
isn't at the start of a sentence.
