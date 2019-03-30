Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860E1C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 02:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55784218D8
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 02:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbfC3Ckp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 22:40:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:60113 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730184AbfC3Cko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 22:40:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 19:40:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,287,1549958400"; 
   d="p7s'?scan'208";a="311638495"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga005.jf.intel.com with ESMTP; 29 Mar 2019 19:40:42 -0700
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 29 Mar 2019 19:40:43 -0700
Received: from orsmsx109.amr.corp.intel.com ([169.254.11.11]) by
 ORSMSX113.amr.corp.intel.com ([169.254.9.249]) with mapi id 14.03.0415.000;
 Fri, 29 Mar 2019 19:40:42 -0700
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Janakarajan.Natarajan@amd.com" <Janakarajan.Natarajan@amd.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "lenb@kernel.org" <lenb@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: Re: [PATCH 5/6] acpi/cppc: Add support for optional CPPC registers
Thread-Topic: [PATCH 5/6] acpi/cppc: Add support for optional CPPC registers
Thread-Index: AQHU5LR0lnkbassgoEK1gi6uIOOyFaYjhPcAgABq5IA=
Date:   Sat, 30 Mar 2019 02:40:41 +0000
Message-ID: <ccdecc9a3eb4cd0e930ce1dbe9f161cf37a71f07.camel@intel.com>
References: <cover.1553285718.git.Janakarajan.Natarajan@amd.com>
         <d16e973c3fa4343134f6d246cc424f29ff5d7dc9.1553285718.git.Janakarajan.Natarajan@amd.com>
         <f3a749646c66a84e17383204385d8c73750d4813.camel@intel.com>
         <SN6PR12MB26399489011DD026910B6049F85A0@SN6PR12MB2639.namprd12.prod.outlook.com>
In-Reply-To: <SN6PR12MB26399489011DD026910B6049F85A0@SN6PR12MB2639.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.191.133]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-3puxkU1l2a00ggyCdCtN"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-3puxkU1l2a00ggyCdCtN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-03-29 at 20:18 +0000, Ghannam, Yazen wrote:
> > -----Original Message-----
> > From: linux-acpi-owner@vger.kernel.org <
> > linux-acpi-owner@vger.kernel.org> On Behalf Of Pandruvada, Srinivas
> > Sent: Wednesday, March 27, 2019 10:48 AM
> > To: linux-kernel@vger.kernel.org; devel@acpica.org; Natarajan,
> > Janakarajan <Janakarajan.Natarajan@amd.com>; linux-
> > acpi@vger.kernel.org; linux-pm@vger.kernel.org
> > Cc: Ghannam, Yazen <Yazen.Ghannam@amd.com>; lenb@kernel.org;=20
> > viresh.kumar@linaro.org; Moore, Robert
> > <robert.moore@intel.com>; Schmauss, Erik <erik.schmauss@intel.com>;
> > rjw@rjwysocki.net
> > Subject: Re: [PATCH 5/6] acpi/cppc: Add support for optional CPPC
> > registers
> >=20
> > On Fri, 2019-03-22 at 20:26 +0000, Natarajan, Janakarajan wrote:
> > > From: Yazen Ghannam <Yazen.Ghannam@amd.com>
> > >=20
> > > Newer AMD processors support a subset of the optional CPPC
> > > registers.
> > > Create show, store and helper routines for supported CPPC
> > > registers.
> > >=20
> > > Signed-off-by: Yazen Ghannam <Yazen.Ghannam@amd.com>
> > > [ carved out into a patch, cleaned up, productized ]
> > > Signed-off-by: Janakarajan Natarajan <
> > > Janakarajan.Natarajan@amd.com>
> > >=20
> >=20
> > [..]
> >=20
> > > +	/* desired_perf is the only mandatory value in perf_ctrls */
> > > +	if (cpc_read(cpu, desired_reg, &desired))
> > > +		ret =3D -EFAULT;
> > > +
> > > +	if (CPC_SUPPORTED(max_reg) && cpc_read(cpu, max_reg, &max))
> > > +		ret =3D -EFAULT;
> > > +
> >=20
> > We should create and use different macro other than CPPC_SUPPORTED.
> > CPC_SUPPORTED doesn't validate the correctness of object type for a
> > field. For example "Maximum Performance Register" can only be
> > buffer
> > not integer. In this way invalid field definitions can be ignored.
> >=20
>=20
> So create something like "CPPC_SUPPORTED_BUFFER" for buffer-only
> registers?
>=20
> And then buffer/integer registers will continue to use
> "CPPC_SUPPORTED".
>=20
> These seem to be the only two cases at this time. Is this okay?
Yes.

Thanks,
Srinivas

>=20
> Thanks,
> Yazen
>=20
> >=20
> > > +	if (CPC_SUPPORTED(min_reg) && cpc_read(cpu, min_reg, &min))
> > > +		ret =3D -EFAULT;
> > > +
> > > +	if (CPC_SUPPORTED(energy_reg) && cpc_read(cpu, energy_reg,
> > > &energy))
> > > +		ret =3D -EFAULT;
> > > +
> > > +	if (CPC_SUPPORTED(auto_sel_enable_reg) &&
> > > +	    cpc_read(cpu, auto_sel_enable_reg, &auto_sel_enable))
> > > +		ret =3D -EFAULT;
> > > +
> >=20
> > Here it is fine to use CPC_SUPPORTED as the "Autonomous Selection
> > Enable" can be both integer and buffer.
> >=20
> > Thanks,
> > Srinivas
>=20
>=20

--=-3puxkU1l2a00ggyCdCtN
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
3SyI6+n6vMJgXVPqCZ+UUkqssxrHlBE2Wa5Z0MvLJIGB/Rwm/FA63bht6f4JWZH5uoRzW4SuyhsR
xVcjLhL3AgMBAAGjggI9MIICOTAdBgNVHQ4EFgQUqm34QzHPi1eNUuCtd75VDPG++SgwHwYDVR0j
BBgwFoAU2kEjnFqPca9Xgz4g0+Nl2wzLC9swZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5p
bnRlbC5jb20vcmVwb3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWlu
ZyUyMENBJTIwNEIuY3JsMIGfBggrBgEFBQcBAQSBkjCBjzAiBggrBgEFBQcwAYYWaHR0cDovL29j
c3AuaW50ZWwuY29tLzBpBggrBgEFBQcwAoZdaHR0cDovL3d3dy5pbnRlbC5jb20vcmVwb3NpdG9y
eS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENBJTIw
NEIuY3J0MAsGA1UdDwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9
gSiFjp9TgpHACWeB3r05lfBDAgFkAgEJMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMM
MCkGCSsGAQQBgjcVCgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBXBgNVHREEUDBOoC0G
CisGAQQBgjcUAgOgHwwdc3Jpbml2YXMucGFuZHJ1dmFkYUBpbnRlbC5jb22BHXNyaW5pdmFzLnBh
bmRydXZhZGFAaW50ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQA7saUQRNb6+9biC882UTQMmxO9
6cbLa4/jipKD0mQvmUpZn/vcTTfQRKahKyW9mUFdbXvC7dVPvOF3LWTj1PK96TcnEssbWKVmJJ3t
gNjnoc8Yuj8AsOi5ErV+KXqJBddMyM7QLQprBlvSNLhZaT4OdT+561W4WVkBJf6hNPUwDn48+x/n
Cb/qTdIehTd+Oh1Rb3wyk2Ll268rRqO6/8cdi2NrrBfMX23wpl0MBCXCUMAD07Otx/bgoTJmLnZi
LNoR7WuA45dz6gNv6h4156p2qyZ8zmYWhjkR7fwBlUV10bFty4/PLghz2BIEH/QsHuY+QxSfFXCl
SsaBUrbEHklWMYICFzCCAhMCAQEwgZAweTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYD
VQQHEwtTYW50YSBDbGFyYTEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIklu
dGVsIEV4dGVybmFsIEJhc2ljIElzc3VpbmcgQ0EgNEICEzMAAGlQPrQId7Ylrr4AAAAAaVAwCQYF
Kw4DAhoFAKBdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDMz
MDAyNDAzOVowIwYJKoZIhvcNAQkEMRYEFHN0Boc1C+dbTgaNRBMMjknw9ItZMA0GCSqGSIb3DQEB
AQUABIIBAMoT1n+Z38zl82rGlMAmbvPR8P2y+Oh4lda4WlfWICqAvOyrgSPIaEPC0iREe+j9X2W1
l2lRyBXW1FzBa1JYr4eU8l44RfTTZsTQlCccPENvM0i3IdaAzAAjqFG/Os35/0adP0ZXJ49kLVqV
7iTf+CwenO4muTvBDAIZwyuYoyC5FU5M6vefmdLw/tEtIBq3bRNWyn63qHaZozn5w8HyMJ+6vBmN
VkI0d03gaieXFWElm4vb/Y2pBJ0EP/FyNjnmKE3XfOVZwlsL1FuhrS8V7pdShAa1pc/jT+unY9xN
+gaHo7JD2u3GhBXpQpcKV7jr2o4remYDT7/gyrspz0h1QsMAAAAAAAA=


--=-3puxkU1l2a00ggyCdCtN--
