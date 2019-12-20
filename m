Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4267CC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3052146E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfLTP15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 10:27:57 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.2]:37043 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727233AbfLTP14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 10:27:56 -0500
Received: from [85.158.142.100] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-central-1.aws.symcld.net id 8C/21-05688-978ECFD5; Fri, 20 Dec 2019 15:27:53 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRWlGSWpSXmKPExsVyU+ECq27liz+
  xBiu/61pc3jWHzYHR4/MmuQDGKNbMvKT8igTWjIaPm1gKXgpWnDu4kaWB8SJvFyMXh5DAPkaJ
  xb1fGSGcs4wSP+7vA3I4OdgEtCRmbJ0KZosIaEi8PHqLBaSIWaCTUeL26wNACQ4OYQFvie0vu
  CFqfCTa53+FqreSaH64nR3EZhFQlVjQNI0JpJxXwFdi3/d0iF0TGCWWfDjBClLDKWAoMfXpCj
  YQm1FAVuLRyl9gvcwC4hK3nsxnArElBAQkluw5zwxhi0q8fPyPFcI2kNi6dB8LhK0ocWM1yEw
  OINta4sYDfogxOhILdn8CG88rIChxcuYTlgmMorOQbJiFpGwWkrIFjMyrGM2TijLTM0pyEzNz
  dA0NDHQNDY11jXVN9RKrdBP1Ukt1k1PzSooSgXJ6ieXFesWVuck5KXp5qSWbGIExk1LIzLqDs
  fnbW71DjJIcTEqivEn+f2KF+JLyUyozEosz4otKc1KLDzHKcHAoSfB+eQaUEyxKTU+tSMvMAc
  YvTFqCg0dJhFfyOVCat7ggMbc4Mx0idYrRnmPCy7mLmDkOHp0HJE+uWgIkb74HkkIsefl5qVL
  ivOwgbQIgbRmleXBDYenmEqOslDAvIwMDgxBPQWpRbmYJqvwrRnEORiVh3haQKTyZeSVwu18B
  ncUEdBaH5i+Qs0oSEVJSDUwe0oHeQSls08ycosxfLFf7I9L7WUAku1Ig44Xfr+knXvtVatfE1
  27dKWejP1/BuEzLd6LPT45NTyWElFQ8d8+/4M54XV9AaPHbeCk/j/xou7NWuo2z/8/ace9RS9
  PbhhkxH/qSxdgPt5xbG/1MPtf03/fkxh+1+2p01H2PTJmgNXXjvrAFercCPQrCgmTC7+98zT8
  7iK/9D79GWIr17t8vc8z9fWun1gtVnJyTkMH6rkb11PLPepmHeG8fjT8mdnkz82ul6qvvWm2i
  jTdGLq/bv2Oys/4nGaHpz1RKlJJqH3osuV9hoaTWdtf6Oc/82ZpazQ+K2T55GL3m/HK1+6Tky
  uZjFssWh/m/+VzEoMRSnJFoqMVcVJwIAKY0mreyAwAA
X-Env-Sender: david.kim@ncipher.com
X-Msg-Ref: server-25.tower-225.messagelabs.com!1576855672!1028507!2
X-Originating-IP: [217.32.208.5]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.22; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30954 invoked from network); 20 Dec 2019 15:27:53 -0000
Received: from unknown (HELO exukdagfar01.INTERNAL.ROOT.TES) (217.32.208.5)
  by server-25.tower-225.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 20 Dec 2019 15:27:53 -0000
Received: from exukdagfar01.INTERNAL.ROOT.TES (10.194.2.70) by
 exukdagfar01.INTERNAL.ROOT.TES (10.194.2.70) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 20 Dec 2019 15:27:51 +0000
Received: from exukdagfar01.INTERNAL.ROOT.TES ([fe80::48de:aa33:fc4c:d1f5]) by
 exukdagfar01.INTERNAL.ROOT.TES ([fe80::48de:aa33:fc4c:d1f5%14]) with mapi id
 15.00.1497.000; Fri, 20 Dec 2019 15:27:51 +0000
From:   "Kim, David" <david.kim@ncipher.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Magee, Tim" <tim.magee@ncipher.com>
Subject: RE: [PATCH 1/1] drivers: misc: Add support for nCipher HSM devices
Thread-Topic: [PATCH 1/1] drivers: misc: Add support for nCipher HSM devices
Thread-Index: AQHVtN0iUtD2ObauYk2ExPz0BKUZFqe+VCKAgATU3UA=
Date:   Fri, 20 Dec 2019 15:27:51 +0000
Message-ID: <f5a9bf8828194315b4a9444480f52e11@exukdagfar01.INTERNAL.ROOT.TES>
References: <20191217132244.14768-1-david.kim@ncipher.com>
 <20191217132244.14768-2-david.kim@ncipher.com>
 <20191217133605.GC3362771@kroah.com>
In-Reply-To: <20191217133605.GC3362771@kroah.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.194.37.115]
x-exclaimer-md-config: 7ae4f661-56ee-4cc7-9363-621ce9eeb65f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I'm just about to push v2 of our patch but wanted to address your comments in the emails you raised them in.

> > +
> > +/* Device ioctl struct definitions */
> > +
> > +/* Result of the ENQUIRY ioctl. */
> > +struct nfdev_enquiry_str {
> > +	__u32 busno; /**< Which bus is the PCI device on. */
> > +	__u8 slotno; /**< Which slot is the PCI device in. */
> > +	__u8 reserved[3]; /**< for consistent struct alignment */
> 
> What is this crazy /**< text?
> 
> Please use correct kerneldoc formatting to help document things.

Done. I've also double checked all the other files. Checkpatch didn't seem to complain about these so we missed them, sorry.

> > + */
> > +#define NFDEV_CONTROL_HARMLESS(c) ((c) <= 1)
> 
> Why does userspace need this?
> 

It doesn't. We've removed that and a couple other leftovers.

> > +enum {
> > +	/** Enquiry ioctl.
> > +	 *  \return nfdev_enquiry_str describing the attached device.
> > +	 */
> > +	NFDEV_IOCTL_NUM_ENQUIRY = 1,
> > +
> > +	/** Channel Update ioctl.
> > +	 *  \deprecated
> > +	 */
> > +	NFDEV_IOCTL_NUM_CHUPDATE,
> 
> You have to explicitly set your enums if you want them to work properly in an
> ioctl.  As it is, this will fail in nasty ways you can never debug :(
> 

Thanks, we've set them explicitly and also removed the unnecessary ones.

> > +
> > +#define NFDEV_IOCTL_DEBUG                                                      \
> > +	_IOW(NFDEV_IOCTL_TYPE, NFDEV_IOCTL_NUM_DEBUG, int)
> 
> Why do you care about debugging to userspace through an ioctl?  Just use
> debugfs and be done with it, that's what it is there for.  Also you can use
> dynamic debugging (hopefully you already are) and use that kernel-wide
> api/interface.
> 
> Individual drivers should NEVER have custom debugging controls and macros.

Yes, this was accidentally left in. It's been removed now.

> 
> > +
> > +#define NFDEV_IOCTL_PCI_IFVERS                                                 \
> > +	_IOW(NFDEV_IOCTL_TYPE, NFDEV_IOCTL_NUM_PCI_IFVERS, int)
> 
> Can't you get this from the pci device information?
> 

Unfortunately not. Each time the device is brought up or has its state changed, the IFVERS is re-negotiated. This call is our means of discovering what IFVER is supported by the currently running firmware.

Thanks,
Dave
