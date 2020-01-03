Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BB0C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 07:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBAE24650
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 07:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="N2xLPdFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgACHZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 02:25:42 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:42383 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbgACHZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 02:25:42 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47pxJf6qxmz7s;
        Fri,  3 Jan 2020 08:25:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1578036339; bh=01dE5Uj2UX6Z3xkoH4ovrHrnnZMZ0qsgpPflyJoviKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N2xLPdFB7kkCfcrgZqjz286M4Iq2z2R0bQRr2/j2GroNvf2U1wd814qwT24QmYTsK
         wtaalcj/wRagy+2bqMZogxgtMskLYpXndjpv4m8npeG3DMrRFU1rPnh3wmowiVo4Ou
         0xQTSVD6iaFUGeiSfOR7qjhuL5FJ9zqUoOYydPfLX6wXI93/0W1xQeB8CtV/z7yaxW
         qM8FlTiLHeAtcRALqEFsX+IqGkj6s/Rv0nNR3hhYvlUUmpwtYbOLjwXRHgZDwDhjm5
         Zf5TYIJPES8884u6RB2erVtdPji6I9QiTT0evrg/3Ms7WSe3qF17uIEvZYToyfFR+N
         0/vREuSglWQdw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Fri, 3 Jan 2020 08:25:36 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Peter Chen <peter.chen@nxp.com>, Rob Herring <robh-dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/10] usb: chipidea: tegra: Add USB_TEGRA_PHY module
 to driver's dependencies
Message-ID: <20200103072536.GA14228@qmqm.qmqm.pl>
References: <20191220015238.9228-1-digetx@gmail.com>
 <20191220015238.9228-11-digetx@gmail.com>
 <20191220035650.GC19921@b29397-desktop>
 <fb7dee6e-e645-fe45-126c-c5f1e280bc26@gmail.com>
 <20191223213234.GA28786@qmqm.qmqm.pl>
 <7174833f-8325-7fb4-d190-78ba4bed0cbb@gmail.com>
 <20191230210259.GD24135@qmqm.qmqm.pl>
 <b34972e3-569e-d74a-4d30-d52c89032a08@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b34972e3-569e-d74a-4d30-d52c89032a08@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 06:17:47PM +0300, Dmitry Osipenko wrote:
> 31.12.2019 00:02, Michał Mirosław пишет:
> > On Tue, Dec 24, 2019 at 07:21:05AM +0300, Dmitry Osipenko wrote:
> >> 24.12.2019 00:32, Michał Mirosław пишет:
> >>> On Fri, Dec 20, 2019 at 07:31:08AM +0300, Dmitry Osipenko wrote:
> >>>> 20.12.2019 06:56, Peter Chen пишет:
> >>>>> On 19-12-20 04:52:38, Dmitry Osipenko wrote:
> >>> [...]
> >>>>>> --- a/drivers/usb/chipidea/ci_hdrc_tegra.c
> >>>>>> +++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
> >>>>>> @@ -53,6 +53,12 @@ static int tegra_udc_probe(struct platform_device *pdev)
> >>>>>>  	struct tegra_udc *udc;
> >>>>>>  	int err;
> >>>>>>  
> >>>>>> +	if (IS_MODULE(CONFIG_USB_TEGRA_PHY)) {
> >>>>>> +		err = request_module("phy_tegra_usb");
> >>>>>> +		if (err)
> >>>>>> +			return err;
> >>>>>> +	}
> >>>>>> +
> >>>>>
> >>>>> Why you do this dependency, if this controller driver can't
> >>>>> get USB PHY, it should return error. What's the return value
> >>>>> after calling below:
> >>>>>
> >>>>> 	udc->phy = devm_usb_get_phy_by_phandle(&pdev->dev, "nvidia,phy", 0);
> >>>>
> >>>> It returns -EPROBE_DEFER when phy_tegra_usb isn't loaded.
> >>>
> >>> How are other driver modules autoloaded? Isn't there an appropriate
> >>> MODALIAS or MODULE_DEVICE_TABLE in there?
> >>
> >> Hello Michał,
> >>
> >> The phy_tegra_usb module is fine by itself, it's getting autoloaded.
> >>
> >> The problem is that ci_hdrc_tegra module depends on the phy_tegra_usb
> >> module and thus the PHY module should be loaded before the CI module,
> >> otherwise CI driver fails with the EPROBE_DEFER.
> > 
> > Why, then, is CI driver not being probed again after PHY driver loads?
> > EPROBE_DEFER is what should cause driver core to re-probe a device after
> > other devices appear (PHY in this case).
> 
> CI driver is getting re-probed just fine if PHY's driver module is
> loaded manually after loading the CI's module. This patch removes this
> necessity to manually load PHY's module.
> 
> This is just a minor convenience change that brings the CI's driver
> loading behaviour on par with the behaviour of loading Tegra's EHCI
> driver module.

I fully understand the goal, but what I'm missing is that why this
doesn't work out of the box? If the PHY module is autoloaded, and so is
CI driver, and (as I understand) the driver's probe() correctly returns
EPROBE_DEFER when PHY is not probed yet, then I guess that means bug
somewhere else and the patch just covers it up.

Best Regards,
Michał Mirosław
