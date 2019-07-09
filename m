Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB91C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E70821707
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfGIHNG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 03:13:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:44877 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfGIHNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:13:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 00:13:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,469,1557212400"; 
   d="scan'208";a="167898846"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga003.jf.intel.com with ESMTP; 09 Jul 2019 00:13:01 -0700
Received: from fmsmsx162.amr.corp.intel.com (10.18.125.71) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 9 Jul 2019 00:12:38 -0700
Received: from hasmsx107.ger.corp.intel.com (10.184.198.27) by
 fmsmsx162.amr.corp.intel.com (10.18.125.71) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 9 Jul 2019 00:12:37 -0700
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.15]) by
 hasmsx107.ger.corp.intel.com ([169.254.2.129]) with mapi id 14.03.0439.000;
 Tue, 9 Jul 2019 10:12:35 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
        "Arnd Bergmann" <arnd@arndb.de>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>
Subject: RE: linux-next: manual merge of the char-misc tree with the
 driver-core tree
Thread-Topic: linux-next: manual merge of the char-misc tree with the
 driver-core tree
Thread-Index: AQHVJyoWchJOzGveSk+BQ8pCoENHp6bBT2iAgACmBpA=
Date:   Tue, 9 Jul 2019 07:12:34 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DC6C94D@hasmsx108.ger.corp.intel.com>
References: <20190620153552.1392079c@canb.auug.org.au>
 <20190709095109.3b75679b@canb.auug.org.au>
In-Reply-To: <20190709095109.3b75679b@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzU5YmExN2QtOGVmNS00ZmJkLTkzMTEtNGRhOTY2YWE0MDc4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiR1phODdEQ0dUSDA3WFA2ckhJMFQ3blpySUN4RDdVODEzYmpOc0liWDFBVTJaZENhdTlBVjNTZ0x5RjJ5K1VUaiJ9
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
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
> Hi all,
> 
> On Thu, 20 Jun 2019 15:35:52 +1000 Stephen Rothwell <sfr@canb.auug.org.au>
> wrote:
> >
> > Today's linux-next merge of the char-misc tree got a conflict in:
> >
> >   drivers/misc/mei/debugfs.c
> >
> > between commit:
> >
> >   5666d896e838 ("mei: no need to check return value of debugfs_create
> > functions")
> >
> > from the driver-core tree and commit:
> >
> >   b728ddde769c ("mei: Convert to use DEFINE_SHOW_ATTRIBUTE macro")
> >
> > from the char-misc tree.
> >
> > I fixed it up (see below) and can carry the fix as necessary. This is
> > now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your
> > tree is submitted for merging.  You may also want to consider
> > cooperating with the maintainer of the conflicting tree to minimise
> > any particularly complex conflicts.
> >
> > --
> > Cheers,
> > Stephen Rothwell
> >
> > diff --cc drivers/misc/mei/debugfs.c
> > index df6bf8b81936,47cfd5005e1b..000000000000
> > --- a/drivers/misc/mei/debugfs.c
> > +++ b/drivers/misc/mei/debugfs.c
> > @@@ -233,22 -154,46 +154,21 @@@ void mei_dbgfs_deregister(struct
> mei_de
> >    *
> >    * @dev: the mei device structure
> >    * @name: the mei device name
> >  - *
> >  - * Return: 0 on success, <0 on failure.
> >    */
> >  -int mei_dbgfs_register(struct mei_device *dev, const char *name)
> > +void mei_dbgfs_register(struct mei_device *dev, const char *name)
> >   {
> >  -	struct dentry *dir, *f;
> >  +	struct dentry *dir;
> >
> >   	dir = debugfs_create_dir(name, NULL);
> >  -	if (!dir)
> >  -		return -ENOMEM;
> >  -
> >   	dev->dbgfs_dir = dir;
> >
> >  -	f = debugfs_create_file("meclients", S_IRUSR, dir,
> >  -				dev, &mei_dbgfs_meclients_fops);
> >  -	if (!f) {
> >  -		dev_err(dev->dev, "meclients: registration failed\n");
> >  -		goto err;
> >  -	}
> >  -	f = debugfs_create_file("active", S_IRUSR, dir,
> >  -				dev, &mei_dbgfs_active_fops);
> >  -	if (!f) {
> >  -		dev_err(dev->dev, "active: registration failed\n");
> >  -		goto err;
> >  -	}
> >  -	f = debugfs_create_file("devstate", S_IRUSR, dir,
> >  -				dev, &mei_dbgfs_devstate_fops);
> >  -	if (!f) {
> >  -		dev_err(dev->dev, "devstate: registration failed\n");
> >  -		goto err;
> >  -	}
> >  -	f = debugfs_create_file("allow_fixed_address", S_IRUSR | S_IWUSR,
> dir,
> >  -				&dev->allow_fixed_address,
> >  -				&mei_dbgfs_allow_fa_fops);
> >  -	if (!f) {
> >  -		dev_err(dev->dev, "allow_fixed_address: registration
> failed\n");
> >  -		goto err;
> >  -	}
> >  -	return 0;
> >  -err:
> >  -	mei_dbgfs_deregister(dev);
> >  -	return -ENODEV;
> >  +	debugfs_create_file("meclients", S_IRUSR, dir, dev,
> > - 			    &mei_dbgfs_fops_meclients);
> > ++			    &mei_dbgfs_meclients_fops);
> >  +	debugfs_create_file("active", S_IRUSR, dir, dev,
> > - 			    &mei_dbgfs_fops_active);
> > ++			    &mei_dbgfs_active_fops);
> >  +	debugfs_create_file("devstate", S_IRUSR, dir, dev,
> > - 			    &mei_dbgfs_fops_devstate);
> > ++			    &mei_dbgfs_devstate_fops);
> >  +	debugfs_create_file("allow_fixed_address", S_IRUSR | S_IWUSR, dir,
> >  +			    &dev->allow_fixed_address,
> > - 			    &mei_dbgfs_fops_allow_fa);
> > ++			    &mei_dbgfs_allow_fa_fops);
> >   }
> > -
> 
> I am still getting this conflict (the commit ids may have changed).
> Just a reminder in case you think Linus may need to know.

The conflict is resolved correctly,  the conflicts are between Greg's misc-char  and driver-core git trees.
Actually I've asked Greg this git expertise question: how the **exact** conflict resolution is carried between git trees (before it is finally resolved in upstream for all.). 
For next time If anyone has the answer, please let me know.

Thanks
Tomas

