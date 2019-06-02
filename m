Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA986C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 16:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F1B27967
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 16:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfFBQYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:24:10 -0400
Received: from smtprelay0191.hostedemail.com ([216.40.44.191]:54467 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726229AbfFBQYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 12:24:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 141AF181D341B;
        Sun,  2 Jun 2019 16:24:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: step34_5e2c6f8ec3b0c
X-Filterd-Recvd-Size: 1526
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Sun,  2 Jun 2019 16:24:07 +0000 (UTC)
Message-ID: <49d8590ebae49ab572bf0f2dbeadf3de2cdeb7e8.camel@perches.com>
Subject: Re: [PATCH] pci: hotplug: Replace function names with __func__ Macro
From:   Joe Perches <joe@perches.com>
To:     benniciemanuel78@gmail.com, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sebastian Ott <sebott@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 02 Jun 2019 09:24:05 -0700
In-Reply-To: <20190602161254.31521-1-benniciemanuel78@gmail.com>
References: <20190602161254.31521-1-benniciemanuel78@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-06-02 at 18:12 +0200, Emanuel Bennici wrote:
> Replace hardcoded function names with __func__ Macro so if the function
> name changes we have not to check all Messages and to retain the code
> structure.

trivia:

__func__ isn't a macro, it's a predefined identifier.
see the c90 standard section 6.4.2.2



