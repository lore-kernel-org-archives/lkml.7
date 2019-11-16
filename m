Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6D6C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 12:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA37D20700
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 12:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfKPMI6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 07:08:58 -0500
Received: from mga07.intel.com ([134.134.136.100]:52807 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727474AbfKPMI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 07:08:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2019 04:08:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,312,1569308400"; 
   d="scan'208";a="406934313"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga006.fm.intel.com with ESMTP; 16 Nov 2019 04:08:57 -0800
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 16 Nov 2019 04:08:56 -0800
Received: from hasmsx107.ger.corp.intel.com (10.184.198.27) by
 FMSMSX155.amr.corp.intel.com (10.18.116.71) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 16 Nov 2019 04:08:56 -0800
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.66]) by
 hasmsx107.ger.corp.intel.com ([169.254.2.168]) with mapi id 14.03.0439.000;
 Sat, 16 Nov 2019 14:08:53 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc-next] mei: bus: add more client attributes to sysfs
Thread-Topic: [char-misc-next] mei: bus: add more client attributes to sysfs
Thread-Index: AQHVnHIYaV4WCqSUt0SW8MHHb8kk8aeNj+AAgAAieMA=
Date:   Sat, 16 Nov 2019 12:08:52 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DD16447@hasmsx108.ger.corp.intel.com>
References: <20191116142136.17535-1-tomas.winkler@intel.com>
 <20191116115824.GB425445@kroah.com>
In-Reply-To: <20191116115824.GB425445@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDQ4MGIxNDYtMDZmZC00NzRhLTk1YmYtNWMyOWQ2NDk5YmFmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUk1GajEycUlOcFMxSTBkbHhsUzVDNGl5MG9rdUlaTG5TMmpBQUtVbW40aTVHMVlvMkt4N3FDMFM1WFZqaDJEMyJ9
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.184.70.11]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Sat, Nov 16, 2019 at 04:21:36PM +0200, Tomas Winkler wrote:
> > From: Alexander Usyskin <alexander.usyskin@intel.com>
> >
> > Export more client attributes via sysfs that are usually obtained upon
> > connection. In some cases, for example a monitoring application may
> > wish to know the attributes without actually performing the connection.
> > Added attributes:
> > max number of connections, fixed address, max message length.
> >
> > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-mei | 21 +++++++++++++++
> >  drivers/misc/mei/bus.c                  | 33 +++++++++++++++++++++++
> >  drivers/misc/mei/client.h               | 36 +++++++++++++++++++++++++
> >  3 files changed, 90 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-mei
> > b/Documentation/ABI/testing/sysfs-bus-mei
> > index 3f8701e8fa24..3d37e2796d5a 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-mei
> > +++ b/Documentation/ABI/testing/sysfs-bus-mei
> > @@ -26,3 +26,24 @@ KernelVersion:	4.3
> >  Contact:	Tomas Winkler <tomas.winkler@intel.com>
> >  Description:	Stores mei client protocol version
> >  		Format: %d
> > +
> > +What:		/sys/bus/mei/devices/.../max_conn
> > +Date:		Nov 2019
> > +KernelVersion:	5.5
> > +Contact:	Tomas Winkler <tomas.winkler@intel.com>
> > +Description:	Stores mei client maximum number of connections
> > +		Format: %d
> > +
> > +What:		/sys/bus/mei/devices/.../fixed
> > +Date:		Nov 2019
> > +KernelVersion:	5.5
> > +Contact:	Tomas Winkler <tomas.winkler@intel.com>
> > +Description:	Stores mei client fixed address, if any
> > +		Format: %d
> > +
> > +What:		/sys/bus/mei/devices/.../max_len
> > +Date:		Nov 2019
> > +KernelVersion:	5.5
> > +Contact:	Tomas Winkler <tomas.winkler@intel.com>
> > +Description:	Stores mei client maximum message length
> > +		Format: %d
> > diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c index
> > 53bb394ccba6..a0a495c95e3c 100644
> > --- a/drivers/misc/mei/bus.c
> > +++ b/drivers/misc/mei/bus.c
> > @@ -791,11 +791,44 @@ static ssize_t modalias_show(struct device *dev,
> > struct device_attribute *a,  }  static DEVICE_ATTR_RO(modalias);
> >
> > +static ssize_t max_conn_show(struct device *dev, struct device_attribute
> *a,
> > +			     char *buf)
> > +{
> > +	struct mei_cl_device *cldev = to_mei_cl_device(dev);
> > +	u8 maxconn = mei_me_cl_max_conn(cldev->me_cl);
> > +
> > +	return scnprintf(buf, PAGE_SIZE, "%d", maxconn);
> 
> Nit, you can just do sprintf() for sysfs file attributes as you "know"
> the buffer is big enough and your variable will fit.
> 
> Not a bit deal, but something to do in the future.


Right, missed that, I can fix it in a follow up patch or resend this one.
Thanks
Tomas


