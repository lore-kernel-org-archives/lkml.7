Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C762ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1446621A4A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfJKJe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 05:34:29 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59544 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfJKJe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 05:34:28 -0400
Received: from 79.184.255.36.ipv4.supernova.orange.pl (79.184.255.36) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id a0b32ad35fcc8a8e; Fri, 11 Oct 2019 11:34:26 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device property: Fix the description of struct fwnode_operations
Date:   Fri, 11 Oct 2019 11:34:26 +0200
Message-ID: <2273648.9qLR0ZJYZ8@kreacher>
In-Reply-To: <20191008140306.GN32742@smile.fi.intel.com>
References: <20191008132606.56434-1-heikki.krogerus@linux.intel.com> <20191008140306.GN32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, October 8, 2019 4:03:06 PM CEST Andy Shevchenko wrote:
> On Tue, Oct 08, 2019 at 04:26:06PM +0300, Heikki Krogerus wrote:
> > Adding description for the device_is_available member which
> > was missing, and fixing the description of the member
> > property_read_int_array.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> > 
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >  include/linux/fwnode.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> > index 6ae05b9ce359..fc002aacae8d 100644
> > --- a/include/linux/fwnode.h
> > +++ b/include/linux/fwnode.h
> > @@ -50,11 +50,11 @@ struct fwnode_reference_args {
> >   * struct fwnode_operations - Operations for fwnode interface
> >   * @get: Get a reference to an fwnode.
> >   * @put: Put a reference to an fwnode.
> > + * @device_is_available: Return true if the device is available.
> >   * @device_get_match_data: Return the device driver match data.
> >   * @property_present: Return true if a property is present.
> > - * @property_read_integer_array: Read an array of integer properties. Return
> > - *				 zero on success, a negative error code
> > - *				 otherwise.
> > + * @property_read_int_array: Read an array of integer properties. Return zero on
> > + *			     success, a negative error code otherwise.
> >   * @property_read_string_array: Read an array of string properties. Return zero
> >   *				on success, a negative error code otherwise.
> >   * @get_parent: Return the parent of an fwnode.
> 
> 

Applying as 5.5 material, thanks!



