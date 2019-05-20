Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F78AC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D217206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbfETIwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:52:05 -0400
Received: from sauhun.de ([88.99.104.3]:49178 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728958AbfETIwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:52:05 -0400
Received: from localhost (p54B333DA.dip0.t-ipconnect.de [84.179.51.218])
        by pokefinder.org (Postfix) with ESMTPSA id 43F282C2761;
        Mon, 20 May 2019 10:52:02 +0200 (CEST)
Date:   Mon, 20 May 2019 10:52:01 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-rockchip@lists.infradead.org,
        Double Lo <double.lo@cypress.com>, briannorris@chromium.org,
        Madhan Mohan R <madhanmohan.r@cypress.com>, mka@chromium.org,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Jiong Wu <lohengrin1024@gmail.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Avri Altman <avri.altman@wdc.com>, Martin Hicks <mort@bork.org>
Subject: Re: [PATCH 2/3] mmc: core: API for temporarily disabling
 auto-retuning due to errors
Message-ID: <20190520085201.GA1021@kunai>
References: <20190517225420.176893-1-dianders@chromium.org>
 <20190517225420.176893-3-dianders@chromium.org>
 <20190519090642.GA2279@kunai>
 <36cae1d3-f11c-3c71-3f04-23fdc74f8866@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <36cae1d3-f11c-3c71-3f04-23fdc74f8866@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2019 at 10:46:19AM +0200, Arend Van Spriel wrote:
> On 5/19/2019 11:06 AM, Wolfram Sang wrote:
> >=20
> > > Let's add an API that the SDIO card drivers can call that will
> > > temporarily disable the auto-tuning functionality.  Then we can add a
> > > call to this in the Broadcom WiFi driver and any other driver that
> > > might have similar needs.
> >=20
> > Can't you fix the WiFi driver to return something else than -EILSEQ
> > before calling mmc_request_done() to skip the retuning?
>=20
> Not really. mmc_request_done() is for the host controller driver so the w=
ifi
> driver is not involved.

Uh, right. Brown paper bag, please...


--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlziaq0ACgkQFA3kzBSg
KbaQVA//WXYFC+BIrlY0Pul+9dGBD8PAFC8f7fZUdwUGDjSC/CI1SfSMkOojpbLX
MQvDlzKvpYj/rS3+xcrNQjgRELPn9DdKWXUEU6CZkgo+xs/cbms1H9fg65UwkVk3
VARN5T2AgnFidWfXrxnD+LxRudQnj6LQqifhfUq6I0X+CfQ7AcDH80gC7FdPCwO5
RM2gC+NNczRd3zxKKWQNXLvuY+yHzx71kHc5+gd5GVRqzsLYwgYQWj1wd6hpUuqY
Ur+m6uUUoQo66teAA+FF+injciq6DJhwqZwa1pvkw7/hXorBArzBbHo3EAqch/hA
349urJNcPBhbN+FCBzjhN+3XpoJATd4DM69v157zYHd2I1QFOiDqBukksD3OBuSk
BRRfrSO2fcTVraEVTtTSgsl8e9eHvGP5hkpwl3GGq+1YvoC5/jOJAXwh17g4vQGD
/wIPqA7a2Edd3Ei3uVjdquqBmmGGDQXADgE+fS9U/gbq/632tXdJ8c25eFUBlN8N
KekuqSINDVvdEHnuy1yKTf7LU0q2hZjifSTU9in3ynzFZSe7ZghCrro/HBCeKBF3
lPCZ2Qf3GlexViNy5/FhvNXPoWQY1sYh0fWMYzOuKm2VEdznrpt5oTtasTapIzy6
9vf04EbfsMnAmHTPi8Hteo+jvczd+rYgFGg6hY/t8FiPtKgWwfs=
=zF+7
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
