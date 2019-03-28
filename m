Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2F9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21975206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfC1Qez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:34:55 -0400
Received: from smtprelay0232.hostedemail.com ([216.40.44.232]:37408 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726029AbfC1Qey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:34:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 29068180AA51A;
        Thu, 28 Mar 2019 16:34:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: birth84_81c6b7977a304
X-Filterd-Recvd-Size: 1655
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Thu, 28 Mar 2019 16:34:51 +0000 (UTC)
Message-ID: <158b68a902139066f53d308cc5a428774445a05b.camel@perches.com>
Subject: Re: [PATCH 00/23] Include linux ACPI docs into Sphinx TOC tree
From:   Joe Perches <joe@perches.com>
To:     Changbin Du <changbin.du@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date:   Thu, 28 Mar 2019 09:34:50 -0700
In-Reply-To: <20190328162721.26138-1-changbin.du@gmail.com>
References: <20190328162721.26138-1-changbin.du@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-29 at 00:26 +0800, Changbin Du wrote:
> Hi Corbet and All,
> The kernel now uses Sphinx to generate intelligent and beautiful documentation
> from reStructuredText files. I converted most of the Linux ACPI docs to rst
> format in this serias.
[]
>  ...pio-properties.txt => gpio-properties.rst} |  76 +++--

Please also update this MAINTAINERS entry

MAINTAINERS-GPIO ACPI SUPPORT
MAINTAINERS-M:  Mika Westerberg <mika.westerberg@linux.intel.com>
MAINTAINERS-M:  Andy Shevchenko <andriy.shevchenko@linux.intel.com>
MAINTAINERS-L:  linux-gpio@vger.kernel.org
MAINTAINERS-L:  linux-acpi@vger.kernel.org
MAINTAINERS-S:  Maintained
MAINTAINERS:F:  Documentation/acpi/gpio-properties.txt
MAINTAINERS-F:  drivers/gpio/gpiolib-acpi.c
MAINTAINERS-


