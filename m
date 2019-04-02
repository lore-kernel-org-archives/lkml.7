Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90EEC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB34207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbfDBI55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:57:57 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54647 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfDBI54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:57:56 -0400
Received: from 79.184.254.219.ipv4.supernova.orange.pl (79.184.254.219) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id d1c8cf8634d7581f; Tue, 2 Apr 2019 10:57:54 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thomas Preston <thomas.preston@codethink.co.uk>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v3] Documentation: acpi: Add an example for PRP0001
Date:   Tue, 02 Apr 2019 10:55:50 +0200
Message-ID: <1647899.RmuxU4V1Im@aspire.rjw.lan>
In-Reply-To: <20190326094827.GN3622@lahna.fi.intel.com>
References: <20190325165338.5826-1-thomas.preston@codethink.co.uk> <20190326094827.GN3622@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 26, 2019 10:48:27 AM CEST Mika Westerberg wrote:
> On Mon, Mar 25, 2019 at 04:53:38PM +0000, Thomas Preston wrote:
> > Add an example for the magic PRP0001 device ID which allows matching
> > ACPI devices against drivers using OF Device Tree compatible property.
> > 
> > Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 

Patch applied, thanks!

